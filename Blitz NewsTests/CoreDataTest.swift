//
//  CoreDataTest.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/27/17.
//  Test case class for testing core data layer for the application
//


import XCTest

@testable import Blitz_News

class CoreDataTest: XCTestCase
{
    // MARK:- Test Data
    
    // Returns a list of news source IDs for testing
    fileprivate let testNewsSourceIDs = ["test_source_01", "test_source_02", "test_source_03"]
    
    // MARK:- Tests
    
    // Test to ensure that a new news source is successfully added to core data and then deleted
    func testNewsSourceInsertionAndDeletion()
    {
        let source = CoreDataManager.sharedInstance.createOrGetNewsSource(sourceID: "test-source", description: "test news source", name: "Test Source", categoryID: "general")
        
        XCTAssert(source != nil)
        
        let sourceFromCD = CoreDataManager.sharedInstance.createOrGetNewsSource(sourceID: "test-source", description: "test news source", name: "Test Source", categoryID: "general")
        
        XCTAssert(sourceFromCD != nil)
        
        // delete test object from database
        CoreDataManager.sharedInstance.deleteNewsSource(sourceID: sourceFromCD!.sourceID!)
        XCTAssert((CoreDataManager.sharedInstance.getNewsSourceForID("test-source")) == nil)
    }
    
    // Test to ensure that news sources are fetched
    func testNewsSourceFetch()
    {
        // add some default news source objects
        for sourceID in testNewsSourceIDs {
            CoreDataManager.sharedInstance.createOrGetNewsSource(sourceID: sourceID, description: "test news source: \(sourceID)", name: sourceID, categoryID: "test")
        }
        
        // fetch and find the sources with matching IDs
        let sourcesFromCD = CoreDataManager.sharedInstance.getNewsSources(userSelectedSources: false)
        XCTAssert(sourcesFromCD.count > 0)
        
        // enusre IDs match
        let matchedSources = sourcesFromCD.filter { return testNewsSourceIDs.contains($0.sourceID!) }
        XCTAssert(matchedSources.count == testNewsSourceIDs.count)
        
        // delete test data
        for sourceID in testNewsSourceIDs {
            CoreDataManager.sharedInstance.deleteNewsSource(sourceID: sourceID)
        }
    }
}
