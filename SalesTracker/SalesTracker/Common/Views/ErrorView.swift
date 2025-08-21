//
//  ErrorView.swift
//  SalesTracker
//
//  Created by Damian Modernell on 12/6/25.
//

import SwiftUI

struct ErrorView: View {
    @Binding var errorText: String
    @State private var isVisible: Bool = false
    @State private var dismissTask: Task<Void, Never>?

    private let animationDuration: TimeInterval = 0.4
    private let autoDismissDelay: UInt64 = 3_000_000_000 // 3 seconds in nanoseconds

    var body: some View {
        VStack {
            // Push the error view down below navigation
            Spacer()
                .frame(height: 100)

            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.white)
                    .font(.system(.title3))

                Text(errorText)
                    .font(.system(.subheadline, design: .rounded, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [Color.red, Color.red.opacity(0.8)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .shadow(
                        color: Color.red.opacity(0.3),
                        radius: 8,
                        x: 0,
                        y: 4
                    )
            )
            .padding(.horizontal, 20)
            .opacity(isVisible ? 1.0 : 0.0)
            .scaleEffect(isVisible ? 1.0 : 0.95)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onChange(of: errorText) { _, newValue in
            handleErrorTextChange(newValue)
        }
        .onAppear {
            if !errorText.isEmpty {
                showErrorWithAutoDismiss()
            }
        }
        .onDisappear {
            dismissTask?.cancel()
        }
    }

    private func handleErrorTextChange(_ newValue: String) {
        dismissTask?.cancel()

        if !newValue.isEmpty {
            showErrorWithAutoDismiss()
        } else {
            hideError()
        }
    }

    private func showErrorWithAutoDismiss() {
        showError()
        scheduleAutoDismiss()
    }

    private func showError() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            isVisible = true
        }
    }

    private func hideError() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            isVisible = false
        }
    }

    private func scheduleAutoDismiss() {
        dismissTask = Task {
            try? await Task.sleep(nanoseconds: autoDismissDelay)

            guard !Task.isCancelled else { return }

            await MainActor.run {
                hideError()
                scheduleErrorTextClear()
            }
        }
    }

    private func scheduleErrorTextClear() {
        Task {
            try? await Task.sleep(nanoseconds: UInt64(animationDuration * 1_000_000_000))

            guard !Task.isCancelled else { return }

            await MainActor.run {
                errorText = ""
            }
        }
    }
}

#Preview {
    @Previewable @State var aString = "The connection appears to be offline"
    ErrorView(errorText: $aString)
}
