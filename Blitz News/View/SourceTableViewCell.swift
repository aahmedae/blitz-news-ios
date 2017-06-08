//
//  SourceTableViewCell.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/16/17.
//  Custom table view cell used to display a news source
//

import UIKit

class SourceTableViewCell: UITableViewCell
{
    @IBOutlet weak var sourceTitleLabel: UILabel!
    @IBOutlet weak var sourceDescriptionLabel: UILabel!
    @IBOutlet weak var checkBox: UICheckBox!
    
    // must be set from the VC (for alternating colour scheme)
    var cellColor = UIColor.white {
        didSet {
            contentView.backgroundColor = cellColor
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool)
    {
        super.setHighlighted(highlighted, animated: animated)
        
        // color inversion when tapped by the user for nice UI effect
        if highlighted {
            sourceTitleLabel.textColor = UISettings.SOURCE_CELL_TEXT_SELECTED_COLOR
            sourceDescriptionLabel.textColor = UISettings.SOURCE_CELL_TEXT_SELECTED_COLOR
            contentView.backgroundColor = UISettings.SOURCE_CELL_HIGHLIGHTED_COLOR
        }
        else {
            sourceTitleLabel.textColor = UISettings.SOURCE_CELL_TEXT_COLOR
            sourceDescriptionLabel.textColor = UISettings.SOURCE_CELL_TEXT_COLOR
            contentView.backgroundColor = cellColor
        }
    }
}
