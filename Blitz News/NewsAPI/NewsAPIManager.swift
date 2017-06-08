//
//  NewsAPIManager.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/13/17.
//  Class responsible for making API calls to the Google News API and parsing the returned json
//

import Foundation
import SwiftyJSON
import Alamofire

class NewsAPIManager
{
    // singleton access
    static let sharedInstance = NewsAPIManager()
    private init() {}
    
    // API keys and settings
    fileprivate let API_KEY = "4e71fb837e434e23a5027fd3a85181c7"
    fileprivate let NEWS_URL = "https://newsapi.org/v1/articles?source=${source_id}&sortBy=top&apiKey=4e71fb837e434e23a5027fd3a85181c7"
    fileprivate let SOURCES_URL = "https://newsapi.org/v1/sources?language=en"
    fileprivate let USER_DEFAULTS_SOURCES_KEY = "kUserSavedSources"
    
    // Public properties
    let categoryIDs = ["business", "entertainment", "gaming", "general", "music", "politics", "science-and-nature", "sport", "technology"]
    let categoryNames = ["business": "Business", "entertainment": "Entertainment", "gaming": "Gaming", "general": "General", "music": "Music", "politics": "Politics", "science-and-nature": "Science and Nature", "sport": "Sport", "technology": "Technology"]
    
    // Errors
    enum Error {
        case none
        case noConnection
        case timeout
        case serverResponseFailed
        case unknown
    }
    
    // MARK:- Public API
    
    // Returns an array of news items for the given source to the handler
    func newsItemsForSource(sourceID: String, handler: @escaping (_ items: [NewsItem]?, _ error: Error) -> Void)
    {
        let url = NEWS_URL.replacingOccurrences(of: "${source_id}", with: sourceID)
        
        downloadJSONForURL(url: url) { (json, error) in
            
            // check for error
            if json == nil {
                handler(nil, error)
                return
            }
            
            if json!["status"].stringValue == "ok"
            {
                // valid json - parse and package into model object
                var newsItems = [NewsItem]()
                let newsItemsJsonArray = json!["articles"].arrayValue
                
                // iterate through json array of news items and push into model array
                for itemJson in newsItemsJsonArray
                {
                    let newsItem = NewsItem()
                    
                    newsItem.newsTitle = itemJson["title"].stringValue
                    newsItem.newsDescription = itemJson["description"].stringValue
                    newsItem.contentURL = itemJson["url"].stringValue
                    newsItem.imageURL = itemJson["urlToImage"].stringValue
                    
                    newsItems.append(newsItem)
                }
                
                handler(newsItems, .none)
            }
            else
            {
                handler(nil, .serverResponseFailed)
            }
        }
    }
    
    // Returns an array of sources to the handler
    func newsSources(handler: @escaping (_ sources: [NewsSource]?, _ error: Error) -> Void)
    {
        downloadJSONForURL(url: SOURCES_URL) { (json, error) in
            
            // check for error
            if json == nil {
                handler(nil, error)
                return
            }
            
            if json!["status"].stringValue == "ok"
            {
                var newsSources = [NewsSource]()
                let newsSourcesJsonArray = json!["sources"].arrayValue
                
                // iterate through all inner news source objects and append to model array
                for sourceJson in newsSourcesJsonArray
                {
                    if let source = CoreDataManager.sharedInstance.createOrGetNewsSource(sourceID: sourceJson["id"].stringValue, description: sourceJson["description"].stringValue, name: sourceJson["name"].stringValue, categoryID: sourceJson["category"].stringValue) {
                        newsSources.append(source)
                    }
                }
                
                handler(newsSources, .none)
            }
            else
            {
                handler(nil, .serverResponseFailed)
            }
        }
    }
    
    // MARK:- Private functions
    
    // Download json for news source
    fileprivate func downloadJSONForURL(url: String, handler: @escaping (_ json: JSON?, _ error: Error) -> Void)
    {
        // first ensure valid network connection
        if !(NetworkReachabilityManager()!.isReachable) {
            handler(nil, .noConnection)
            return
        }
        
        // handle request and convert response into SwiftyJSON object
        Alamofire.request(url).responseJSON { (response) in
            if response.result.isSuccess
            {
                // check for error first
                if response.error != nil {
                    handler(nil, .unknown)
                    return
                }
                
                // all good - get the JSON
                if let responseValue = response.result.value
                {
                    let json = JSON(responseValue)
                    handler(json, .none)
                }
            }
            else
            {
                handler(nil, .serverResponseFailed)
            }
        }
    }
}
