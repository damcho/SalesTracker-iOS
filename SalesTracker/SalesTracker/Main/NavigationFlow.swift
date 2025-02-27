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
    case productDetail(String, [Product: [Sale]])
}

class NavigationFLow: ObservableObject {
    @Published var navigationPath: NavigationPath
        
    init(tokenLoadable: TokenLoadable) {
        if let anAccessToken = try? tokenLoadable.loadAccessToken() {
            navigationPath = NavigationPath(
                [
                    Screen.productsList(anAccessToken)
                ]
            )
        } else {
            navigationPath = NavigationPath()
        }
    }
    
    func push(_ screen: Screen) {
        navigationPath.append(screen)
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    func resolveInitialScreen() -> LoginScreen {
        return SalesTrackerApp.composeLoginScreen(
            successfulAuthAction: { accesstoken in
                self.push(.productsList(accesstoken))
            }
        )
    }
    
    func destinations(for screen: Screen) -> any View {
        switch screen {
        case .login:
            return resolveInitialScreen()
        case .productsList(let accessToken):
            let productsList = ProductsListComposer.compose(
                accessToken: accessToken,
                productSelection: {_, _ in },
                authErrorHandler: {
                    self.popToRoot()
                }
            )
            return productsList.navigationBarBackButtonHidden(true)
        case .productDetail(let productSalesDic):
            return AnyView(EmptyView())
        }
    }
}
