//
//  VKGroupViewController.swift
//  VKAppClone
//
//  Created by elf on 10.05.2021.
//

import Foundation
import UIKit
import WebKit

class VKGroupViewController: UIViewController, WKUIDelegate {

    var group: VKGroup?
    
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(buildGroupPageRequest())
    }
  
    private func buildGroupPageRequest() -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "vk.com"
        guard let path = group?.screenName else { return URLRequest(url: components.url!)}
        components.path = "/\(path)"

        return URLRequest(url: components.url!)
    }
}

extension VKGroupViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard navigationResponse.response.url?.path == "/blank.html" else {
            decisionHandler(.allow)
            return
        }
        decisionHandler(.cancel)
    }
}

