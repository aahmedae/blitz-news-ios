//
//  SourcesViewController.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/16/17.
//  VC reponsible for simply displaying the sources the user prefers and navigating to the news VC to show news for that source
//

import UIKit

class SourcesViewController: NewsSourceViewController
{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sourcesMessageLabel: UILabel!
    
    // MARK:- Setup
    
    override func viewWillAppear(_ animated: Bool)
    {
        loadSources()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        allowUserSelections = false
        view.backgroundColor = UISettings.VC_BACKGROUND_COLOR
    }
    
    // Loads the data for the sources
    fileprivate func loadSources()
    {
        // load sources from core data storage
        sources = CoreDataManager.sharedInstance.getNewsSources(userSelectedSources: true)
        
        // set user message if no sources
        sourcesMessageLabel.isHidden = (sources.count > 0)
        
        // clear out categoryIDs for new batch of data since the user might have removed a category
        categoryIDs.removeAll()
        
        // set the category IDs for sources that the user has selected
        for source in sources
        {
            if !categoryIDs.contains(source.categoryID!) {
                categoryIDs.append(source.categoryID!)
            }
        }
        
        categoryIDs.sort()
        
        setupNewsSourceTableView(tableView: tableView)
    }
    
    // MARK:- Table View
    
    // User taps on cell to navigate to see news for that source
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: false)
        
        // navigate to news list view controller
        let source = sourceForIndexPath(indexPath)
        performSegue(withIdentifier: "ToNewsListVC", sender: source)
    }
    
    // MARK:- Events
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addSourcesVC = storyboard.instantiateViewController(withIdentifier: "AddSourcesVC")
        present(addSourcesVC, animated: true, completion: nil)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // set the source for the news list VC to show
        if let vc = segue.destination as? NewsListViewController {
            if let source = sender as? NewsSource {
                vc.source = source
            }
        }
    }
}
