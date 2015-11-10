//
//  Question.swift
//  iQuiz
//
//  Created by Cechi Shi on 11/10/15.
//  Copyright © 2015 Cechi Shi. All rights reserved.
//

import Foundation

struct Question {
    var question: String
    var answer: String
    var choices: [String]
    
    init(question: String, answer: String, choices: [String]) {
        self.question = question
        self.answer = answer
        self.choices = choices
    }
}