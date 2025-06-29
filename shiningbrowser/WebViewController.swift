//
//  ViewController.swift
//  shiningbrowser
//
//  Created by DigerAPP on 16.06.2025.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate  {
    
    @IBOutlet weak var WebViewObject: WKWebView!
    @IBOutlet weak var ProgressBar: UIProgressView!
    var selectedUrl = ""
    @IBOutlet weak var CloseBtn: UIImageView!
    @IBOutlet weak var BackwardButton: UIImageView!
    @IBOutlet weak var ForwardButton: UIImageView!
    @IBOutlet weak var RefreshButton: UIImageView!
    
     /*
      * Func viewDidLoad()
      */
    override func viewDidLoad() {
        super.viewDidLoad()
        Clicks()
        
        WebViewObject.uiDelegate = self
        WebViewObject.navigationDelegate = self
        WebViewObject.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)

        
        let generateURL = URL(string: selectedUrl)!
        let generateURLRequest = URLRequest(url: generateURL)
        WebViewObject.load(generateURLRequest)
        
        
    }
    
    private func Clicks() {
        
        CloseBtn.isUserInteractionEnabled = true
        let closeClick = UITapGestureRecognizer(target:self , action: #selector(CloseButtonClick))
        CloseBtn.addGestureRecognizer(closeClick)
        
        BackwardButton.isUserInteractionEnabled = true
        let backwardClick = UITapGestureRecognizer(target:self , action: #selector(BackwardButtonClick))
        BackwardButton.addGestureRecognizer(backwardClick)
        
        ForwardButton.isUserInteractionEnabled = true
        let forwardClick = UITapGestureRecognizer(target:self , action: #selector(ForwardButtonClick))
        ForwardButton.addGestureRecognizer(forwardClick)
        
        RefreshButton.isUserInteractionEnabled = true
        let refreshClick = UITapGestureRecognizer(target:self , action: #selector(RefreshButtonClick))
        RefreshButton.addGestureRecognizer(refreshClick)
        
    }
    
    func animateShadowOnImage(_ imageView: UIImageView) {
        // Gölgeyi ekle
        imageView.layer.shadowColor =  #colorLiteral(red: 0.631372549, green: 0.4862745098, blue: 0.2352941176, alpha: 1)
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        imageView.layer.shadowRadius = 0
        imageView.layer.masksToBounds = false

        // Gölgeyi yavaşça yok et
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [.curveEaseOut]) {
            imageView.layer.shadowOpacity = 0
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
           
            if (ProgressBar.isHidden && WebViewObject.estimatedProgress != 1.0)
            {
                ProgressBar.isHidden = false
            }
            
            ProgressBar.progress = Float(WebViewObject.estimatedProgress)
            
            if (WebViewObject.estimatedProgress == 1.0)
            {
                ProgressBar.isHidden = true
            }
        }
    }
    
    /*
     * @objc Func SearchButtonClick()
     */
    @objc private func CloseButtonClick() {
        animateShadowOnImage(CloseBtn)
        RemoveStarSite()
        OpenViewController()
    }
    
    /*
     * @objc Func SearchButtonClick()
     */
    @objc private func ForwardButtonClick() {
        animateShadowOnImage(ForwardButton)
        
        if WebViewObject.canGoForward {
            WebViewObject.goForward()
          }
       
        
    }
    
    /*
     * @objc Func SearchButtonClick()
     */
    @objc private func BackwardButtonClick() {
        
        animateShadowOnImage(BackwardButton)
        if WebViewObject.canGoBack {
            WebViewObject.goBack()
          }
        
    }
    
    /*
     * @objc Func SearchButtonClick()
     */
    @objc private func RefreshButtonClick() {
        animateShadowOnImage(RefreshButton)
       
        WebViewObject.reload()
    }
    
    private func OpenViewController() {
        let ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        ViewController.modalPresentationStyle = .fullScreen
        self.present(ViewController,animated: true)
    }
    
}

