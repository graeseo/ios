import SwiftUI
import WebKit

struct MainFeedView: View {
    @State private var viewModel: MainFeedViewModel
    @State private var isLoading = true

    init(feedUrl: String) {
        _viewModel = State(initialValue: MainFeedViewModel(feedUrl: feedUrl))
    }

    var body: some View {
        ZStack {
            WebView(url: viewModel.feedUrl, isLoading: $isLoading)
                .ignoresSafeArea()

            if isLoading {
                ProgressView()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

private struct WebView: UIViewRepresentable {
    let url: String
    @Binding var isLoading: Bool

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let parsed = URL(string: url), webView.url != parsed else { return }
        webView.load(URLRequest(url: parsed))
    }

    func makeCoordinator() -> Coordinator { Coordinator(isLoading: $isLoading) }

    final class Coordinator: NSObject, WKNavigationDelegate {
        @Binding var isLoading: Bool

        init(isLoading: Binding<Bool>) {
            _isLoading = isLoading
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            isLoading = false
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            isLoading = false
        }
    }
}
