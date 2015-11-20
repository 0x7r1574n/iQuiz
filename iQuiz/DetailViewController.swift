//
//  DetailViewController.swift
//  iQuiz
//
//  Created by Cechi Shi on 11/3/15.
//  Copyright © 2015 Cechi Shi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var choiceSegments: UISegmentedControl!
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    var quiz = Quiz(title: "", description: "", questions: [])
    
    var questionIndex = 0
    var selectedIndex = 0
    var score = 0
    var count = 0

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        let question = self.quiz.questions[questionIndex]
        self.questionLabel.text = question.question
        for i in 0...3 {
            choiceSegments.setTitle(question.choices[i], forSegmentAtIndex: i)
        }
        self.submitButton.enabled = false
    }
    
    
    @IBAction func selectChoice(sender: UISegmentedControl) {
        self.selectedIndex = sender.selectedSegmentIndex
        self.submitButton.enabled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToAnswer" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! AnswerViewController
            let question = self.quiz.questions[questionIndex]
            controller.isCorrect = (selectedIndex == Int(question.answer)! - 1)
            controller.questionIndex = self.questionIndex
            controller.quiz = self.quiz
            controller.score = self.score
            controller.count = self.count
        }
    }


}

