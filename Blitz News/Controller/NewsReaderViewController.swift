//
//  NewsReaderViewController.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/14/17.
//  VC responsible for displaying a news article in a web browser
//

import UIKit
import WebKit

class NewsReaderViewController: UIViewController, WKUIDelegate, WKNavigationDelegate
{
    // MARK:- Outlets and Variables
    
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    // the url of the article to navigate to (must be set by the calling VC)
    var url: URL!
    
    fileprivate var webView: WKWebView!
    
    // MARK:- Setup
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UISettings.VC_BACKGROUND_COLOR
        loadWebView()
    }
    
    // Load the web view
    fileprivate func loadWebView()
    {
        let config = WKWebViewConfiguration()
        
        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.backgroundColor = UISettings.VC_BACKGROUND_COLOR
        webView.uiDelegate = self
        webView.navigationDelegate = self

        view.addSubview(webView)
        view.sendSubview(toBack: webView)
        
        webView.load(URLRequest(url: url))
    }
    
    // MARK:- Web View Navigation
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!)
    {
        activitySpinner.stopAnimating()
    }
    
    // MARK:- Events
    
    // User taps on the action button to share the news URL
    @IBAction func actionButtonTapped(_ sender: UIBarButtonItem)
    {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityVC.popoverPresentationController?.barButtonItem = sender
        present(activityVC, animated: true, completion: nil)
    }
}
