//
//  ProductsListComposer.swift
//  SalesTracker
//
//  Created by Damian Modernell on 23/2/25.
//

import Foundation
import SwiftUI

typealias ProductSelectionHandler = (Product) -> Void

enum ProductsListComposer {
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
        return dateFormatter
    }

    static func composeProductSalesLoader(with authToken: String) -> RemoteProductSalesLoader {
        RemoteProductSalesLoader(
            mapper: ProductMapper.map,
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
        authErrorHandler: @escaping () -> Void
    )
        -> any View
    {
        let errorViewModel = ErrorViewModel(dismisErrorAction: authErrorHandler)
        return compose(
            with: productsLoadable,
            errorViewModel: errorViewModel,
            authErrorHandler: authErrorHandler
        ).withErrorHandler(errorViewModel)
    }

    @MainActor
    static func compose(
        with productsLoadable: ProductSalesLoadable,
        errorViewModel: ErrorViewModel,
        authErrorHandler: @escaping () -> Void
    )
        -> ProductListView
    {
        let productSalesAdapter = ProductSalesLoaderAdapter(
            productSalesLoader: ErrorDisplayableDecorator(
                decoratee: productsLoadable,
                errorDisplayable: errorViewModel
            ),
            productsOrder: { view1, view2 in
                view1.viewModel.productName < view2.viewModel.productName
            }
        )

        return ProductListView(
            navigationBarTitle: "Products",
            onRefresh: {
                try await productSalesAdapter.loadProductsAndSales()
            }
        )
    }

    @MainActor
    static func compose(
        accessToken: String,
        authErrorHandler: @escaping () -> Void
    )
        -> any View
    {
        compose(
            with: composeProductSalesLoader(
                with: accessToken
            ),
            authErrorHandler: authErrorHandler
        )
    }
}
