//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Harshitha Akkaraju on 2/14/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    var category : [String : Any] = [ : ]
    var quizScore : Int = 0
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var message: UILabel!
    
    @IBAction func nextPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "backToList", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let questions = category["questions"] as! [Any]
        score.text = String(self.quizScore) + " / " + String(questions.count)
        message.text = "Nice Job!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
