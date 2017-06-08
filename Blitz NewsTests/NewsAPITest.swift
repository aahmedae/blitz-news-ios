//
//  NewsAPITest.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/28/17.
//  Test case for testing the News API manager for this application
//

import XCTest

@testable import Blitz_News

class NewsAPITest: XCTestCase
{
    // MARK:- Test Parameters
    
    fileprivate let MAX_EXPECTATION_DURATION: TimeInterval = 5.0
    fileprivate let NEWS_SOURCE_TEST_ID = "bbc-news"
    
    // MARK:- Tests
    
    // Test to ensure that sources are fetched successfully
    func testNewsSourcesRequest()
    {
        let promise = expectation(description: "Sources Downloaded")
        
        NewsAPIManager.sharedInstance.newsSources { (sources, error) in
            
            if error != .none
            {
                XCTFail("Error: \(error)")
            }
            else
            {
                XCTAssert(sources != nil)
                XCTAssert(sources!.count > 0)
                promise.fulfill()
            }
        }
        
        waitForExpectations(timeout: MAX_EXPECTATION_DURATION, handler: nil)
    }
    
    // Test to ensure that news articles are fetched for the given news source
    func testNewsSourceForCategory()
    {
        let promise = expectation(description: "News Sources Downloaded")
        
        NewsAPIManager.sharedInstance.newsItemsForSource(sourceID: NEWS_SOURCE_TEST_ID) { (items, error) in
            
            if error != .none
            {
                XCTFail("Error: \(error)")
            }
            else
            {
                XCTAssert(items != nil)
                XCTAssert(items!.count > 0)
                promise.fulfill()
            }
        }
        
        waitForExpectations(timeout: MAX_EXPECTATION_DURATION, handler: nil)
    }
}
