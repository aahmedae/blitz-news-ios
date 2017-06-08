//
//  NewsSourceViewController.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/22/17.
//  View controller responsible for handling a table view that displays news sources
//

import UIKit

class NewsSourceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    // MARK:- Outlets and variables
    
    // Must be set by child VC in IB
    @IBOutlet weak var newsSourceTableView: UITableView!
    
    // propoerties that are accessible by child classes
    var allowUserSelections = false
    var sources = [NewsSource]()
    var categoryIDs = [String]()
    
    // MARK:- Setup
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UISettings.VC_BACKGROUND_COLOR
    }
    
    // Sets the table view up
    func setupNewsSourceTableView(tableView: UITableView)
    {
        newsSourceTableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        
        newsSourceTableView.separatorColor = UISettings.SOURCE_TABLE_VIEW_SEPARATOR_COLOR
        newsSourceTableView.separatorInset = UISettings.SOURCE_TABLE_VIEW_SEPARATOR_INSETS
        newsSourceTableView.backgroundColor = UISettings.VC_BACKGROUND_COLOR
        newsSourceTableView.indicatorStyle = .white
        
        newsSourceTableView.reloadData()
    }
    
    // MARK:- Table View
    
    // Sections are defined the total number of categories
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return categoryIDs.count
    }
    
    // Rows for section are defined by the number of sources for the given category of that section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let categoryID = categoryIDs[section]
        let sourcesForCategory = sources.filter { return $0.categoryID == categoryID }
        return sourcesForCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let source = sourceForIndexPath(indexPath)
        let cell = NewsSourceVCHelper.getNewsSourceCell(tableView: tableView, indexPath: indexPath, source: source, checkboxVisible: allowUserSelections)
        cell.checkBox.checked = source.userSelected
        
        return cell
    }
    
    // Custom header view for displaying the source category
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let categoryID = categoryIDs[section]
        let categoryName = NewsAPIManager.sharedInstance.categoryNames[categoryID]
        return NewsSourceVCHelper.getNewsSourceCategoryHeader(tableView: tableView, categoryName: categoryName)
    }
    
    // Source category header heigth
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return CGFloat(UISettings.SOURCE_CELL_HEADER_HEIGHT)
    }
    
    // MARK:- Other Functions
    
    // Returns the News Source for the given index path
    func sourceForIndexPath(_ indexPath: IndexPath) -> NewsSource
    {
        let categoryID = categoryIDs[indexPath.section]
        let sourcesForCategory = sources.filter { return $0.categoryID == categoryID }
        let source = sourcesForCategory[indexPath.row]
        
        return source
    }
}
