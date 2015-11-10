//
//  Quiz.swift
//  iQuiz
//
//  Created by Cechi Shi on 11/10/15.
//  Copyright © 2015 Cechi Shi. All rights reserved.
//

import Foundation

struct Quiz {
    var title: String
    var description: String
    var questions: [Question]
    
    init(title: String, description: String, questions: [Question]) {
        self.title = title
        self.description = description
        self.questions = questions
    }
}