//
//  ViewController.swift
//  shiningbrowser
//
//  Created by DigerAPP on 16.06.2025.
//

import UIKit

class LaunchScreenController: UIViewController {
    
     /*
      * Func viewDidLoad()
      */
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    /*
     * Func viewDidLoad()
     */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let starSite = GetStarSite()
    
        if starSite != "" {
            OpenWebView(link: starSite)
            return
        }
        
        OpenViewController()
    }
    
    /*
     * Func OpenWebView()
     */
    private func OpenWebView(link: String) {
        let webView = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webView.modalPresentationStyle = .fullScreen
        webView.selectedUrl = link
        self.present(webView,animated: true)
    }
  
    /*
     * Func OpenViewController()
     */
    private func OpenViewController() {
        let ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        ViewController.modalPresentationStyle = .fullScreen
        self.present(ViewController,animated: true)
    }
    
}

