//
//  UICheckBox.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/16/17.
//  Custom image view used to function as a checkbox with a checked and unchecked state
//

import UIKit

class UICheckBox: UIImageView
{
    @IBInspectable var checkedStateImage: UIImage?
    @IBInspectable var uncheckedStateImage: UIImage?
    
    var checked = false {
        didSet {
            image = (checked ? checkedStateImage : uncheckedStateImage)
        }
    }
    
    override func awakeFromNib()
    {
        checked = false
    }
    
    // Toggles the state
    func toggle()
    {
        checked = !checked
    }
}
