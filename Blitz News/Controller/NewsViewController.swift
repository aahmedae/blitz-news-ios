//
//  NewsViewController.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/13/17.
//  VC responsible for displaying news articles in a tableview
//

import UIKit
import SafariServices
import Alamofire

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    // MARK:- Private variables
    fileprivate var newsTableView = UITableView()
    fileprivate var newsItems = [NewsItem]()
    fileprivate var newsImages = [UIImage?]()
    
    fileprivate let SEGUE_TO_NEWS_READER_VC = "ToReaderViewController"
    
    fileprivate let ROW_HEIGTH_PHONES: CGFloat = 172
    fileprivate let ROW_HEIGTH_IPADS: CGFloat = 280
    
    // MARK:- Setup
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // Setup the table view this VC handles
    func setupTableView(newsTableView: UITableView, newsItems: [NewsItem])
    {
        // set reference to child IBOutlet and the data array
        self.newsTableView = newsTableView
        self.newsItems = newsItems
        self.newsImages = Array<UIImage?>(repeating: nil, count: self.newsItems.count)
        
        // setup table view
        newsTableView.separatorInset = UIEdgeInsets.zero
        newsTableView.dataSource = self
        newsTableView.delegate = self
        
        newsTableView.reloadData()
        
        // load images into memory for table view
        for row in 0 ... newsItems.count - 1 {
            loadNewsItemImageAsync(row: row)
        }
    }
    
    // MARK:- Table View
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "News Item Cell") as? NewsItemTableViewCell
        if cell == nil
        {
            let nib = UINib(nibName: "NewsItemTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "News Item Cell")
            cell = tableView.dequeueReusableCell(withIdentifier: "News Item Cell") as? NewsItemTableViewCell
        }
        
        let newsItem = newsItems[indexPath.row]
        
        // customize the cell
        cell!.titleLabel.text = newsItem.newsTitle
        cell!.descriptionLabel.text = newsItem.newsDescription
        cell!.dateLabel.text = "13th May 2017"
        cell!.sourceLabel.text = newsItem.sourceName
        
        // check if image was downloaded for this cell
        if let image = newsImages[indexPath.row] {
            cell!.backgroundImageView.image = image
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: false)
        
        // show reader VC to view news item
        if let url = URL(string: newsItems[indexPath.row].contentURL) {
            performSegue(withIdentifier: SEGUE_TO_NEWS_READER_VC, sender: url)
        }
    }
    
    // Set height based on device size class
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let height = (UIDevice.current.userInterfaceIdiom == .phone ? ROW_HEIGTH_PHONES : ROW_HEIGTH_IPADS)
        return height
    }
    
    // MARK:- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // set url for news reader to vc to display
        if let url = sender as? URL
        {
            if let vc = segue.destination as? NewsReaderViewController {
                vc.url = url
            }
        }
    }
    
    // MARK:- Private functions
    
    // Loads the image at the given index path row asynchronously
    fileprivate func loadNewsItemImageAsync(row: Int)
    {
        let url = newsItems[row].imageURL
        Alamofire.request(url).responseData { (response) in
            if let data = response.data
            {
                DispatchQueue.main.async
                {
                    let image = UIImage(data: data)
                    self.newsImages[row] = image
                    let path = IndexPath(row: row, section: 0)
                    self.newsTableView.reloadRows(at: [path], with: .fade)
                }
            }
        }
    }
}
