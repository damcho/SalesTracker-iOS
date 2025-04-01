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
    case productDetail(Product)
}

@MainActor
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
        guard Thread.isMainThread else {
            Task { @MainActor in
                navigationPath.append(screen)
            }
            return
        }
        navigationPath.append(screen)
    }

    func popToRoot() {
        guard Thread.isMainThread else {
            Task { @MainActor in
                navigationPath.removeLast(navigationPath.count)
            }
            return
        }
        navigationPath.removeLast(navigationPath.count)
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
                productSelection: { product in
                    self.push(.productDetail(product))
                },
                authErrorHandler: { [weak self] in
                    self?.popToRoot()
                }
            )
            return productsList.navigationBarBackButtonHidden(true)
        case let .productDetail(product):
            return ProductDetailComposer.compose(
                with: product
            )
        }
    }
}
