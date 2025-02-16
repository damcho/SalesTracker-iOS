//
//  ActivityIndicatorView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 16/2/25.
//

import SwiftUI

struct ActivityIndicatorView: View {
    var body: some View {
        ProgressView().controlSize(.large)
    }
}

#Preview {
    ActivityIndicatorView()
}
