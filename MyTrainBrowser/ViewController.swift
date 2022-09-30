//
//  ViewController.swift
//  MyTrainBrowser
//
//  Created by Артём Тюрморезов on 30.09.2022.
//

import UIKit
import WebKit
class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backButon: UIButton!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        urlTextField.delegate = self
        webView.navigationDelegate = self
        super.viewDidLoad()
        let homePage = "https://ya.ru"
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        
        urlTextField.text = homePage
    }


    @IBAction func backAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    @IBAction func forwardAction(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        webView.load(request)
        
        textField.resignFirstResponder()
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlTextField.text = webView.url?.absoluteString
        backButon.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
