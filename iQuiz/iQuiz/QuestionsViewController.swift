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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // no of answer choices
        return 4
    }
    
    // let questionsRepo = QuestionRepo.shared
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answersTable: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func submitClicked(_ sender: UIButton) {
        if (answer != -1) {
            let questions = category["questions"] as! [Question]
            var question = questions[questionNo]
            question.input = self.answer
            performSegue(withIdentifier: "AnswerVC", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answersTable.delegate = self
        answersTable.dataSource = self
        print(category)
        let questions = category["questions"] as! [Any]
        print(questions)
        if (questionNo > questions.count) {
            performSegue(withIdentifier: "AnswerVC", sender: self)
        }
        let question = questions[questionNo]
        // questionLabel.text = question.text
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AnswerViewController {
            let questions = category["questions"] as! [Question]
            let correctAnswer = questions[questionNo].answer
            
            destination.correct = answer == correctAnswer
            destination.answer = questions[questionNo].answers[correctAnswer]
            destination.question = questions[questionNo].text
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

