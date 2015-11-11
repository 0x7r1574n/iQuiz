//
//  ResultViewController.swift
//  iQuiz
//
//  Created by Cechi Shi on 11/10/15.
//  Copyright © 2015 Cechi Shi. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var indicatorLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    var score = 0
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.resultLabel.text = "You got \(score)/\(count) correct"
        if Double(score)/Double(count) > 0.5 {
            self.indicatorLabel.text = "Great job!"
        } else {
            self.indicatorLabel.text = "You can do better!"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = (segue.destinationViewController as! UINavigationController).topViewController as! MasterViewController
        controller.navigationItem.hidesBackButton = true
    }

}
