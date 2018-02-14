//
//  QuestionRepository.swift
//  iQuiz
//
//  Created by Harshitha Akkaraju on 2/13/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import Foundation

class Question {
    var question : String
    var answers : [String]
    var answer: Int
    var input: Int
    
    init(question : String, answers: [String], answer: Int, userInput: Int) {
        self.question = question
        self.answers = answers
        self.answer = answer
        self.input = userInput
    }
}

class QuestionRepo {
    
    static let shared = QuestionRepo()

    private var questions : [String: [Question]] = ["Math": [Question(question: "2 + 2", answers: ["4", "7", "6", "5"], answer: 0, userInput: -1),
                                                             Question(question: "96 - 52", answers: ["43", "44", "56", "54"], answer: 2, userInput: -1)],
                                                    "Science": [Question(question: "What is NaCl", answers: ["Baking soda", "Salt", "Sugar", "Chlorine"], answer: 2, userInput: -1), Question(question: "Light is a ", answers: ["wave", "particle", "both", "neither"], answer: 3, userInput: -1)],
                                                    "Marvel": [Question(question: "What is Peter Parker's middle name?", answers: ["Benjamin", "Mark", "Joseph", "William"], answer: 1, userInput: -1), Question(question: "Where was Galactus born?", answers: ["Oa", "Taa", "Mee", "Blue"], answer: 2, userInput: -1)]]
    
    func getQuestions(category: String) -> [Question] {
        return questions[category]!
    }
    
    func updateQuestion(category: String, questionNo: Int, userInput: Int) {
        if (userInput != -1) {
            questions[category]![questionNo].input = userInput
        }
    }
}
