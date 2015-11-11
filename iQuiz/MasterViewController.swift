//
//  MasterViewController.swift
//  iQuiz
//
//  Created by Cechi Shi on 11/3/15.
//  Copyright © 2015 Cechi Shi. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var quizzes = [Quiz(title: "Mathematics", description: "Some calculation", questions: [Question(question: "1+1", answer: "2", choices: ["1", "2", "3", "4"]), Question(question: "2+2", answer: "4", choices: ["1", "2", "3", "4"]), Question(question: "2*2", answer: "4", choices: ["1", "2", "3", "4"])]), Quiz(title: "Marvel Super Heroes", description: "Character matching", questions: [Question(question: "Who is Tony Stark?", answer: "Iron Man", choices: ["Spiderman", "Batman", "Iron Man", "Baymax"]), Question(question: "Who is the alter-ego for Spiderman?", answer: "Peter Parker", choices: ["Tony Stark", "Steve Rogers", "Johnny Storm", "Peter Parker"]), Question(question: "Who is Steve Rogers?", answer: "Captain America", choices: ["Iron Man", "Superman", "Spiderman", "Captain America"])]), Quiz(title: "Science", description: "What you learned in high school", questions: [Question(question: "What is the chemical equation for water?", answer: "H2O", choices: ["H2", "O2", "H2O", "CO2"]), Question(question: "Which is not a valid chemical element?", answer: "Xp", choices: ["Xp", "S", "Ca", "P"]), Question(question: "Which one is radioactive?", answer: "Ra", choices: ["Ra", "H", "He", "O"])])]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Visually removes empty cells
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        let settingsButton = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: "popupSettingsAlert:")
        self.navigationItem.rightBarButtonItem = settingsButton
        self.navigationItem.leftItemsSupplementBackButton = false
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func popupSettingsAlert(sender: AnyObject) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(confirmAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = quizzes[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.hidesBackButton = true
                controller.navigationItem.title = object.title
                controller.quiz = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let object = quizzes[indexPath.row]
        cell.textLabel!.text = object.title
        cell.detailTextLabel!.text = object.description
        return cell
    }

}

