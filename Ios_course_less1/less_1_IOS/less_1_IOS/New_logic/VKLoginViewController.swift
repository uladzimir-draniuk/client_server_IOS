//
//  VKLoginViewController.swift
//  less_1_IOS
//
//  Created by elf on 19.04.2021.
//


import UIKit
import WebKit

class VKLoginViewController: UIViewController {

    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(buildAuthRequest())
    }

//    @IBAction func unwindAndClearCookies(segue: UIStoryboardSegue) {
//        let cookieStore = webView.configuration.websiteDataStore.httpCookieStore
//
//        cookieStore.getAllCookies { cookies in
//            for cookie in cookies {
//                cookieStore.delete(cookie)
//            }
//        }
//        webView.load(buildAuthRequest())
//    }
    
    private func buildAuthRequest() -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        let scope = 262150 + 8192
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "6704883"),
            URLQueryItem(name: "scope", value: String(scope)),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.92")
        ]
        
        return URLRequest(url: components.url!)
    }
}

extension VKLoginViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard navigationResponse.response.url?.path == "/blank.html",
              let fragment = navigationResponse.response.url?.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        Session.shared.token = params["access_token"] ?? ""
        Session.shared.userId = params["user_id"] ?? ""
        
        performSegue(withIdentifier: "VKLoginShowSegue", sender: nil)
        decisionHandler(.cancel)
    }
}
