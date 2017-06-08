//
//  NewsItemTableViewCell.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/13/17.
//  Custom table view cell for displaying a news article
//

import UIKit

class NewsItemTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var infoView: UIView!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        infoView.layer.cornerRadius = 12.0
        infoView.isHidden = true
    }
    
    override func prepareForReuse()
    {
        backgroundImageView.image = nil
        contentView.layer.contents = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
