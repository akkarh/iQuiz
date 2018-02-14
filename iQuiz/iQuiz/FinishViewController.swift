//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Harshitha Akkaraju on 2/14/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    var category : String = ""
    let questionsRepo = QuestionRepo.shared
    var questions : [Question] = []
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var message: UILabel!
    
    @IBAction func nextPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "backToList", sender: self)
    }
    
    func computeScore() -> Int {
        var numCorrect = 0
        for q in questions {
            if q.answer == q.input {
                numCorrect = numCorrect + 1
            }
        }
        score.text = String(numCorrect) + " / " + String(questions.count)
        return numCorrect
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        questions = questionsRepo.getQuestions(category: category)
        _ = computeScore() // TODO: Customize the message based on the user score
        message.text = "Nice Job!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
