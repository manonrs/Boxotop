//
//  WebView.swift
//  Boxotop
//
//  Created by Manon Russo  on 26/05/2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}


#Preview {
    WebView(url: URL(string: "https://www.google.fr")!)
}
