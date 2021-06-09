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
    
    private func buildGroupPageRequest() -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "vk.com"
        components.path = "/\(group!.screenName)"

        return URLRequest(url: components.url!)
    }
}

extension VKGroupViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard navigationResponse.response.url?.path == "/blank.html"
//              let fragment = navigationResponse.response.url?.fragment
        else {
            decisionHandler(.allow)
            return
        }
        
//        let params = fragment
//            .components(separatedBy: "&")
//            .map { $0.components(separatedBy: "=") }
//            .reduce([String: String]()) { result, param in
//                var dict = result
//                let key = param[0]
//                let value = param[1]
//                dict[key] = value
//                return dict
//        }
//
//        Session.shared.token = params["access_token"] ?? ""
//        Session.shared.userId = params["user_id"] ?? ""
//
//        performSegue(withIdentifier: "VKLoginShowSegue", sender: nil)
        decisionHandler(.cancel)
    }
}

