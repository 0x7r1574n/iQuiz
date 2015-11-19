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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func downloadData(sender: UIButton) {
        let view = MasterViewController()
        view.downloadData(self.urlField.text!)
    }

}
