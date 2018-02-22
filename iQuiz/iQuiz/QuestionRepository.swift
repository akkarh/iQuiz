//
//  QuestionRepository.swift
//  iQuiz
//
//  Created by Harshitha Akkaraju on 2/13/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import Foundation
import UIKit

// struct for Question
struct Question {
    var text : String
    var answer : Int
    var answers : [String]
    var input : Int
    
    // initialize fields
    init(text: String, answer: Int, answers: [String]) {
        self.text = text
        self.answer = answer
        self.answers = answers
        self.input = -1
    }
}

// struct for Category
struct Category {
    var title : String
    var desc : String
    var questions : [Question]
    
    // initialize fields
    init(title : String, description : String, questions : [Question]) {
        self.title = title
        self.desc = description
        self.questions = questions
    }
}
