//
//  NavigationFlow.swift
//  SalesTracker
//
//  Created by Damian Modernell on 26/2/25.
//

import Foundation
import SwiftUI

enum Screen: Hashable {
    case login
    case productsList(String)
    case productDetail(Product, [Sale], CurrencyConverter)
}

class NavigationFLow: ObservableObject {
    @Published var navigationPath: NavigationPath

    init(tokenLoadable: TokenLoadable) {
        if let anAccessToken = try? tokenLoadable.loadAccessToken() {
            self.navigationPath = NavigationPath(
                [
                    Screen.productsList(anAccessToken)
                ]
            )
        } else {
            self.navigationPath = NavigationPath()
        }
    }

    func push(_ screen: Screen) {
        Task { @MainActor in
            navigationPath.append(screen)
        }
    }

    func popToRoot() {
        Task { @MainActor in
            navigationPath.removeLast(navigationPath.count)
        }
    }

    func resolveInitialScreen() -> LoginScreen {
        LoginScreenComposer.composeLoginScreen(
            successfulAuthAction: { accesstoken in
                self.push(.productsList(accesstoken))
            }
        )
    }

    func destinations(for screen: Screen) -> any View {
        switch screen {
        case .login:
            return resolveInitialScreen()
        case let .productsList(accessToken):
            let productsList = ProductsListComposer.compose(
                accessToken: accessToken,
                productSelection: { product, sales, currencyConverter in
                    self.push(.productDetail(product, sales, currencyConverter))
                },
                authErrorHandler: { [weak self] in
                    self?.popToRoot()
                }
            )
            return productsList.navigationBarBackButtonHidden(true)
        case let .productDetail(product, sales, currencyConverter):
            return ProductDetailComposer.compose(
                with: product,
                sales: sales,
                currencyConverter: currencyConverter
            )
        }
    }
}
