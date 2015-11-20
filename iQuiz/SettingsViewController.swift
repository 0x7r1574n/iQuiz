//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Cechi Shi on 11/19/15.
//  Copyright © 2015 Cechi Shi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var urlField: UITextField!
    
    @IBAction func downloadData(sender: UIButton) {
        let view = MasterViewController()
        view.downloadData(self.urlField.text!)
    }

}
