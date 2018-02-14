//
//  QuestionsViewController.swift
//  iQuiz
//
//  Created by Harshitha Akkaraju on 2/12/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // TODO: initialize it upon segue
    var questionNo : Int = 0
    var category : String = ""
    var questions : [Question] = []
    var answer : Int = -1
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // no of choices
    }
    
    let questionsRepo = QuestionRepo.shared
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answersTable: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func submitClicked(_ sender: UIButton) {
        if (answer != -1) {
            questionsRepo.updateQuestion(category: category, questionNo: questionNo, userInput: answer)
            performSegue(withIdentifier: "AnswerVC", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answersTable.delegate = self
        answersTable.dataSource = self
        questions = questionsRepo.getQuestions(category: category)
        questionLabel.text = questions[questionNo].question
        
        // TODO: Finish or delete later
//        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
//        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
//        self.view.addGestureRecognizer(leftSwipe)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AnswerViewController {
            let correctAnswer = questions[questionNo].answer
            destination.correct = answer == correctAnswer
            destination.answer = questions[questionNo].answers[correctAnswer]
            destination.question = questions[questionNo].question
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: customize here
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = questions[questionNo].answers[index]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        self.answer = index
        submitButton.isEnabled = true
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

