//
//  ProductsListComposer.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation

typealias ProductSelectionHandler = (Product, CurrencyConverter) -> Void

enum ProductsListComposer {
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
        return dateFormatter
    }

    static func composeProductSalesLoader(with authToken: String) -> RemoteProductSalesLoader {
        RemoteProductSalesLoader(
            mapper: ProductInfoMapper.map,
            productsLoader: RemoteProductsLoader(
                httpClient: HTTPHeaderDecorator(
                    decoratee: SalesTrackerApp.httpClient,
                    headers: [HTTPHeader.authorization(accessToken: authToken)]
                ),
                url: Source.productsList.getURL(for: Source.baseURL),
                mapper: ProductsListMapper.map
            ),
            remoteSalesLoader: RemoteSalesLoader(
                httpClient: HTTPHeaderDecorator(
                    decoratee: SalesTrackerApp.httpClient,
                    headers: [HTTPHeader.authorization(accessToken: authToken)]
                ),
                url: Source.salesList.getURL(for: Source.baseURL),
                mapper: ProductsSalesMapper(
                    dateFormatter: dateFormatter
                ).map
            ),
            currencyRatesLoader: RemoteCurrencyRatesLoader(
                httpClient: SalesTrackerApp.httpClient,
                url: Source.currencyRates.getURL(for: Source.currencyRatesMiddlewareBaseUrl),
                mapper: CurrencyRatesMapper.map
            )
        )
    }

    @MainActor
    static func compose(
        with productsLoadable: ProductSalesLoadable,
        productSelection: @escaping ProductSelectionHandler,
        authErrorHandler: @escaping () -> Void
    )
        -> ProductListView
    {
        let errorViewModel = ErrorViewModel()
        let productSalesAdapter = ProductSalesLoaderAdapter(
            productSalesLoader: ErrorDisplayableDecorator(
                decoratee: AuthenticationErrorDecorator(
                    authErrorHandler: authErrorHandler,
                    decoratee: productsLoadable
                ),
                errorDisplayable: errorViewModel
            ),
            onSelectedProduct: productSelection,
            productsOrder: { view1, view2 in
                view1.viewModel.productName < view2.viewModel.productName
            }
        )

        return ProductListView(
            navigationBarTitle: "Products",
            errorView: ErrorView(viewModel: errorViewModel),
            onRefresh: {
                try await productSalesAdapter.loadProductsAndSales()
            }
        )
    }

    @MainActor
    static func compose(
        accessToken: String,
        productSelection: @escaping ProductSelectionHandler,
        authErrorHandler: @escaping () -> Void
    )
        -> ProductListView
    {
        compose(
            with: composeProductSalesLoader(
                with: accessToken
            ),
            productSelection: productSelection,
            authErrorHandler: authErrorHandler
        )
    }
}
