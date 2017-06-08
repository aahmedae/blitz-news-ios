//
//  UISettings.swift
//  Blitz News
//
//  Created by Asad Ahmed on 5/14/17.
//  Static constants for UI settings used throughout the app
//

import Foundation
import UIKit

class UISettings
{
    // Status Bar
    static let STATUS_BAR_STYLE = UIStatusBarStyle.lightContent
    
    // Nav Bar
    static let HEADER_BAR_COLOR = UIColor(rgb: 0xE95D4F)
    static let NAV_BAR_HEADER_FONT_COLOR = UIColor(rgb: 0xFFFFFF)
    static let NAV_BAR_HEADER_FONT = UIFont(name: "Futura-Medium", size: 22)!
    
    // Sources View Controller
    static let SOURCE_CELL_COLOUR_01 = UISettings.HEADER_BAR_COLOR
    static let SOURCE_CELL_COLOUR_02 = UISettings.SOURCE_CELL_COLOUR_01.withAlphaComponent(0.90)
    static let SOURCE_CELL_TEXT_COLOR = UIColor.white
    static let SOURCE_CELL_HIGHLIGHTED_COLOR = UIColor.white
    static let SOURCE_CELL_TEXT_SELECTED_COLOR = UISettings.SOURCE_CELL_COLOUR_01
    static let SOURCE_TABLE_VIEW_SEPARATOR_COLOR = UIColor.clear
    static let SOURCE_TABLE_VIEW_SEPARATOR_INSETS = UIEdgeInsets.zero
    static let SOURCE_CELL_HEADER_HEIGHT = 42.0
    static let SOURCE_CELL_HEADER_BACKGROUND_COLOR = UIColor.black.withAlphaComponent(0.75)
    static let SOURCE_CELL_HEADER_TEXT_FONT = UIFont(name: "Futura-Bold", size: 18)
    static let SOURCE_CELL_HEADER_TEXT_COLOR = UIColor.white
    static let SOURCE_CELL_HEADER_BORDER_COLOR = UIColor.white
    static let SOURCE_CELL_HEADER_BORDER_WIDTH = 1.0
    
    // All View Controllers
    static let VC_BACKGROUND_COLOR = UIColor(rgb: 0xE6685B)
}
