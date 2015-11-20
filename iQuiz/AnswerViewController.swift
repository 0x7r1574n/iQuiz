//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Cechi Shi on 11/10/15.
//  Copyright © 2015 Cechi Shi. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    var isCorrect = false
    var questionIndex = 0
    var score = 0
    var count = 0
    var quiz = Quiz(title: "", description: "", questions: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        self.questionLabel.text = self.quiz.questions[self.questionIndex].question
        let question = self.quiz.questions[self.questionIndex]
        // Do any additional setup after loading the view.
        if self.isCorrect {
            self.resultLabel.text = "Correct! :)"
            self.resultLabel.textColor = UIColor.greenColor()
            self.correctAnswerLabel.text = "\(question.choices[Int(question.answer)!]) is the correct answer!"
            self.score++
        } else {
            self.resultLabel.text = "Incorrect! :("
            self.resultLabel.textColor = UIColor.redColor()
            self.correctAnswerLabel.text = "Correct answer is \(question.choices[Int(question.answer)!])."
        }
        self.count++
            }

    @IBAction func nextQuestion(sender: UIBarButtonItem) {
        if self.questionIndex == self.quiz.questions.count - 1 {
            performSegueWithIdentifier("resultPage", sender: self)
        } else {
            self.questionIndex++
            performSegueWithIdentifier("nextQuestion", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "resultPage" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! ResultViewController
            controller.score = self.score
            controller.navigationItem.hidesBackButton = true
            controller.count = self.count
        }
        else if segue.identifier == "nextQuestion" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            controller.navigationItem.title = self.quiz.title
            controller.navigationItem.hidesBackButton = true
            controller.quiz = self.quiz
            controller.count = self.count
            controller.score = self.score
            controller.questionIndex = self.questionIndex
        }
    }
    
}
