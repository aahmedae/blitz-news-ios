//
//  NewsSourceVCHelper
//  Blitz News
//
//  Created by Asad Ahmed on 5/16/17.
//  Utitlity class that holds functions for constructing reusable table view cells and news source related functionality shared by view controllers
//

import Foundation
import UIKit

class NewsSourceVCHelper
{
    // Builds and returns a news source cell
    static func getNewsSourceCell(tableView: UITableView, indexPath: IndexPath, source: NewsSource, checkboxVisible: Bool) -> SourceTableViewCell
    {
        // get cell from nib
        var cell = tableView.dequeueReusableCell(withIdentifier: "Source Cell") as? SourceTableViewCell
        if cell == nil
        {
            let nib = UINib(nibName: "SourceTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "Source Cell")
            cell = tableView.dequeueReusableCell(withIdentifier: "Source Cell") as? SourceTableViewCell
        }
        
        // cell text
        cell!.sourceTitleLabel.text = source.sourceName
        cell!.sourceDescriptionLabel.text = source.sourceDescription
        
        // cell alternating colours
        if (indexPath.row % 2) == 0 {
            cell!.cellColor = UISettings.SOURCE_CELL_COLOUR_02
        }
        else {
            cell!.cellColor = UISettings.SOURCE_CELL_COLOUR_01
        }
        
        // checkbox not used in every vc
        cell!.checkBox.isHidden = !checkboxVisible
        
        return cell!
    }
    
    // Builds a header view for the news source category
    static func getNewsSourceCategoryHeader(tableView: UITableView, categoryName: String?) -> UIView
    {
        // main view for the header
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: CGFloat(UISettings.SOURCE_CELL_HEADER_HEIGHT)))
        view.backgroundColor = UISettings.SOURCE_CELL_HEADER_BACKGROUND_COLOR
        
        // bottom border view
        let bottomBorder = UIView(frame: CGRect(x: 0, y: 0.95 * view.bounds.height, width: view.bounds.width, height: 0.05 * view.bounds.height))
        bottomBorder.backgroundColor = UISettings.SOURCE_CELL_HEADER_BORDER_COLOR
        view.addSubview(bottomBorder)
        
        // bottom border constraints
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: bottomBorder.leadingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomBorder.bottomAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: bottomBorder.trailingAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // label with the title of the category
        let label = UILabel(frame: view.bounds)
        label.textColor = UISettings.SOURCE_CELL_TEXT_COLOR
        label.text = categoryName?.uppercased()
        view.addSubview(label)
        
        // label constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }
    
    // Returns an appropriate error message and title for alert dialogs for the given NewsAPI error
    static func alertDialogMessageAndTitleForAPIError(_ error: NewsAPIManager.Error) -> (title: String, message: String)
    {
        var message = ""
        var title = ""
        
        switch error
        {
        case .noConnection:
            title = "No Internet Connection"
            message = "You are not connected to the internet. Unable to fetch data."
            
        case .serverResponseFailed:
            title = "Server Timeout"
            message = "The server failed to respond. Unable to fetch data."
            
        case .timeout:
            title = "Timeout"
            message = "The server is taking too long to respond"
            
        default:
            title = "Unknown Error"
            message = "An unknown error occurred"
        }
        
        return (title, message)
    }
    
    // Returns an alert dialog for the given news api error
    static func alertDialogForError(_ error: NewsAPIManager.Error) -> UIAlertController
    {
        let info = alertDialogMessageAndTitleForAPIError(error)
        let ac = UIAlertController(title: info.title, message: info.message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return ac
    }
}
