//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Harshitha Akkaraju on 2/13/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var correct : Bool = false
    var answer : String = ""
    var question : String = ""

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextPressed(_ sender: UIButton) {
        print("clicked")
        // performSegue(withIdentifier: "nextQ", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuestionsViewController {
            destination.questionNo = destination.questionNo + 1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // To hide the back button on answer view
        navigationItem.hidesBackButton = true
        nextButton.isEnabled = true
        questionLabel.text = question
        answerLabel.text = answer
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
