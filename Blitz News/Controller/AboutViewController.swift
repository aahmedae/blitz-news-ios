//
//  AboutViewController.swift
//  Blitz News
//
//  Created by Asad Ahmed on 6/2/17.
//  View controller for the about screen. Only handles the button tap to the news api page.
//

import UIKit

class AboutViewController: UIViewController
{
    // Open link in safari
    @IBAction func linkButtonTapped(_ sender: UIButton)
    {
        let url = URL(string: "https://newsapi.org")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
