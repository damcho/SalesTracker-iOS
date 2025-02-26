//
//  NavigationFlow.swift
//  SalesTracker
//
//  Created by Damian Modernell on 26/2/25.
//

import Foundation
import SwiftUI

class NavigationFLow: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    let tokenLoadable: TokenLoadable
    
    init(tokenLoadable: TokenLoadable) {
        self.tokenLoadable = tokenLoadable
    }
    
    func resolveInitialView() -> any View {
        do {
            let accessToken = try tokenLoadable.loadAccessToken()
            return ProductsListComposer.compose(
                with: ProductsListComposer.composeProductSalesLoader(
                    with: accessToken
                ),
                productSelection:  {_, _ in }
            )
        } catch {
            return SalesTrackerApp.composeLoginScreen(
                successfulAuthAction: {}
            )
        }
    }
}
