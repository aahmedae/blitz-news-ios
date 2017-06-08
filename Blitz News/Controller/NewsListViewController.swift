//
//  NewsListViewController.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/16/17.
//  VC responsible for displaying the news list for a news source
//

import UIKit

class NewsListViewController: NewsViewController
{
    // MARK:- Outlets and Variables
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshBarButton: UIBarButtonItem!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var source: NewsSource!
    
    fileprivate var newsItems = [NewsItem]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadNewsForSource()
        
        // table view setup
        tableView.indicatorStyle = .white
        tableView.backgroundColor = UISettings.VC_BACKGROUND_COLOR
        view.backgroundColor = UISettings.VC_BACKGROUND_COLOR
    }
    
    // Loads the news for the source
    fileprivate func loadNewsForSource()
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        refreshBarButton.isEnabled = false
        
        weak var weakSelf = self
        NewsAPIManager.sharedInstance.newsItemsForSource(sourceID: source.sourceID!) { [unowned self] (data, error) in
            
            if error == .none
            {
                if let news = data
                {
                    weakSelf?.newsItems = news
                    
                    DispatchQueue.main.async {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        weakSelf?.spinner.stopAnimating()
                        weakSelf?.refreshBarButton.isEnabled = true
                        weakSelf?.setupTableView(newsTableView: self.tableView, newsItems: self.newsItems)
                    }
                }
            }
            else
            {
                // recevied error when downloading
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    weakSelf?.spinner.stopAnimating()
                    weakSelf?.refreshBarButton.isEnabled = true
                    let ac = NewsSourceVCHelper.alertDialogForError(error)
                    weakSelf?.present(ac, animated: true, completion: nil)
                }
            }
        }
    }

    // User taps on the bar button to refresh the news list for this news source
    @IBAction func refreshBarButtonTapped(_ sender: UIBarButtonItem)
    {
        loadNewsForSource()
    }
}
