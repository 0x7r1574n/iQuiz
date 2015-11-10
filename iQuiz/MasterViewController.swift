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
    var quizzes = [Quiz(title: "Mathematics", description: "Some calculation", questions: []), Quiz(title: "Marvel Super Heroes", description: "Character matching", questions: []), Quiz(title: "Science", description: "What you learned in high school", questions: [])]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Visually removes empty cells
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        let settingsButton = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: "popupSettingsAlert:")
        self.navigationItem.rightBarButtonItem = settingsButton
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
                controller.detailItem = object.title
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
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

