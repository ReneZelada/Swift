

import WebKit


override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
}
