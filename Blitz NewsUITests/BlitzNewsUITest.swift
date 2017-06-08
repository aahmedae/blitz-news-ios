//
//  BlitzNewsUITest.swift
//  Blitz News
//
//  Created by Asad Ahmed on 6/2/17.
//  Tests the UI functionality of the view controllers in the application
//

import XCTest

class BlitzNewsUITest: XCTestCase
{
    // MARK:- Setup
    
    override func setUp()
    {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    // MARK:- Tests
    
    // Test if table view was loaded with sources
    func testUserSourcesVCLoaded()
    {
        let cells = XCUIApplication().tables.cells
        XCTAssert(cells.count > 0)
    }
    
    // Test navigation to news list view controller
    func testNavigationToNewsListVC()
    {
        XCUIApplication().tables.staticTexts["The Wall Street Journal"].tap()
        
        
        // wait for news articles to load as this is an async operation
        expectation(for: NSPredicate(format: "self.count = 1"), evaluatedWith: XCUIApplication().tables, handler: nil)
        waitForExpectations(timeout: 5.0, handler: nil)
        
        XCTAssert(XCUIApplication().tables.cells.count > 0)
    }
    
    // Test to see if sources are loaded for edit sources view controller
    func testEditSourcesVC()
    {
        XCUIApplication().navigationBars["SOURCES"].buttons["Edit"].tap()
        
        // wait for news sources to load as this an async operation
        expectation(for: NSPredicate(format: "self.count = 1"), evaluatedWith: XCUIApplication().tables, handler: nil)
        waitForExpectations(timeout: 5.0, handler: nil)
        
        // ensure table view is now loaded
        XCTAssert(XCUIApplication().tables.cells.count > 0)
    }
    
    // Test to ensure that selecting / deselecting a news source on the edit sources has an effect on the sources view controller
    func testSourceSelections()
    {
        // track number of cells before selecting the preffered sources
        let itemsBeforeSelections = XCUIApplication().tables.cells.count
        
        // select / deselect a number of sources from the edit sources view controller
        let app = XCUIApplication()
        app.navigationBars["SOURCES"].buttons["Edit"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Bloomberg"].tap()
        tablesQuery.staticTexts["Business Insider"].tap()
        tablesQuery.staticTexts["Financial Times"].tap()
        
        // get the cell count back in the sources view controller
        let itemsAfterSelections = XCUIApplication().tables.cells.count
        
        // since selections/deselections have been made, the count should be different
        XCTAssert(itemsBeforeSelections != itemsAfterSelections)
    }
}
