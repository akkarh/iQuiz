//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Harshitha Akkaraju on 2/13/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var category : [String : Any] = [ : ]
    var correct : Bool = false
    var answer : String = ""
    var question : String = ""
    var done : Bool = false
    var questionNo : Int = -1
    var numQs : Int = -1
    var score : Int = 0

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextPressed(_ sender: UIButton) {
        if done {
            performSegue(withIdentifier: "doneVC", sender: self)
        } else {
            performSegue(withIdentifier: "nextQ", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if done {
            if let destination = segue.destination as? FinishViewController {
                destination.category = self.category
                destination.quizScore = self.score
            }
        } else {
            if let destination = segue.destination as? QuestionsViewController {
                destination.questionNo = self.questionNo
                destination.category = self.category
                destination.score = self.score
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // To hide the back button on answer view
        navigationItem.hidesBackButton = true
        nextButton.isEnabled = true
        questionLabel.text = question
        answerLabel.text = answer
        questionNo = questionNo + 1
        done = questionNo >= numQs
        if correct {
            feedbackLabel.text = "🎉 Correct Answer! 🎉"
        } else {
            feedbackLabel.text = "Wrong Answer! 😭"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
