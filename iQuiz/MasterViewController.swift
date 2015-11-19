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
    var quizzes: [Quiz] = []
    
    struct defaultsKeys {
        static let localStorageKey = "LocalStorageKey"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Visually removes empty cells
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        self.navigationItem.leftItemsSupplementBackButton = false
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let stringOne = defaults.stringForKey(defaultsKeys.localStorageKey) {
            parseData(stringOne)
            print("LOADING FROM LOCAL STORAGE") //for test use only
        } else {
            print("LOADING DATA FROM ONLINE") // for test use only
            self.downloadData("https://tednewardsandbox.site44.com/questions.json")
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
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        return
    }
    
    func downloadData(url: String) {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig)
        let URL = NSURL(string: url)
        let request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            do {
                let value = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [AnyObject]
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setValue(String(value), forKey: defaultsKeys.localStorageKey) //storing the content
                defaults.synchronize() //you can store multiple lines at once but then it synchornizes, saving the data
                self.parseData(value)
            } catch {
                print(error)
            }
        }
        task.resume()
        self.tableView.reloadData()
    }
    
    func parseData(data: AnyObject) {
        let json = JSON(data)
        let data = json.array
        for quiz in data! {
            var newQuiz: Quiz = Quiz(title: "", description: "", questions: [])
            newQuiz.title = quiz["title"].stringValue
            newQuiz.description = quiz["desc"].stringValue
            for questionKeys in quiz["questions"].array! {
                var question = Question(question: questionKeys["text"].stringValue, answer: questionKeys["answer"].stringValue, choices: [])
                for choice in questionKeys["answers"].array! {
                    question.choices.append(choice.stringValue)
                }
                newQuiz.questions.append(question)
            }
            self.quizzes.append(newQuiz)
        }
    }

}

