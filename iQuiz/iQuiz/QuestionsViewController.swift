//
//  QuestionsViewController.swift
//  iQuiz
//
//  Created by Harshitha Akkaraju on 2/12/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var category : [String : Any] = [ : ]
    
    var questionNo : Int = 0
    var answer : Int = -1
    var score : Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // no of answer choices
        return 4
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answersTable: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func submitClicked(_ sender: UIButton) {
        if (answer != -1) {
            let questions = category["questions"] as? [Any]
            var question = questions![questionNo] as? [String : Any]
            question!["input"] = self.answer
            performSegue(withIdentifier: "AnswerVC", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answersTable.delegate = self
        answersTable.dataSource = self
        let questions = category["questions"] as! [Any]
        if (questionNo > questions.count) {
            performSegue(withIdentifier: "AnswerVC", sender: self)
        }
        let question = questions[questionNo] as? [String : Any]
        questionLabel.text = question?["text"] as? String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AnswerViewController {
            let questions = category["questions"] as! [Any]
            var question = questions[questionNo] as! [String : Any]
            let answers = question["answers"] as! [String]
            let answerIndex = question["answer"] as! String
            let correctAnswer = answers[Int(answerIndex)! - 1]
            
            destination.correct = answer == (Int(answerIndex)! - 1)
            if answer == (Int(answerIndex)! - 1) {
                self.score = self.score + 1
            }
            destination.score = self.score
            destination.answer = correctAnswer
            destination.question = question["text"] as! String
            destination.category = category
            destination.questionNo = questionNo
            destination.numQs = questions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let questions = category["questions"] as? [Any]
        let question = questions![questionNo] as! [String : Any]
        let answers = question["answers"] as? [String]
        cell.textLabel?.text = answers?[index]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.answer = indexPath.row
        submitButton.isEnabled = true
    }

}

