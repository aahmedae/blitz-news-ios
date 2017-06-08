//
//  SelectSourcesViewController.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/16/17.
//  View controller responsible for handling input for selecting the user's preferred news sources
//

import UIKit

class SelectSourcesViewController: NewsSourceViewController
{
    // MARK:- Outlets and variables
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK:- Setup
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        loadNewsSources()
    }
    
    // Fetches the data for the sources.
    func loadNewsSources()
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        allowUserSelections = true
        
        weak var weakSelf = self
        NewsAPIManager.sharedInstance.newsSources { [unowned self] (data, error) in
            
            if let sources = data
            {
                weakSelf?.sources = sources
                weakSelf?.categoryIDs = NewsAPIManager.sharedInstance.categoryIDs
                
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    weakSelf?.spinner.stopAnimating()
                    weakSelf?.setupNewsSourceTableView(tableView: self.tableView)
                }
            }
            else
            {
                // recevied error when downloading
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    weakSelf?.spinner.stopAnimating()
                    let ac = NewsSourceVCHelper.alertDialogForError(error)
                    weakSelf?.present(ac, animated: true, completion: nil)
                }
            }
        }
    }
    
    // UI setup
    fileprivate func setupUI()
    {
        view.backgroundColor = UISettings.VC_BACKGROUND_COLOR
        tableView.backgroundColor = UISettings.VC_BACKGROUND_COLOR
        tableView.separatorColor = UISettings.SOURCE_TABLE_VIEW_SEPARATOR_COLOR
        tableView.separatorInset = UISettings.SOURCE_TABLE_VIEW_SEPARATOR_INSETS
    }
    
    // MARK:- Table View
    
    // User taps on cell to select / deselect a news source
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // toggle the selection state of the source
        let source = sourceForIndexPath(indexPath)
        source.userSelected = !source.userSelected
        
        // reload table view row to reflect the new changes
        tableView.deselectRow(at: indexPath, animated: false)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    // MARK:- Events
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem)
    {
        // save selected news sources in core data
        CoreDataManager.sharedInstance.save()
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
