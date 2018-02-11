//
//  ViewController.swift
//  iQuiz
//
//  Created by Harshitha Akkaraju on 2/8/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    let subjects : [String] = ["Math", "Science", "Marvel"]
    let descriptions : [String] = ["Do you have a knack for numbers?", "Test your mad science skills", "Do you know your marvel heros?"]
    let images : [UIImage] = [UIImage(named: "Math")!, UIImage(named: "Science")!, UIImage(named: "Marvel")!]
    
    @IBOutlet weak var subjectsTable: UITableView!
    
    @IBAction func settings(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: {_ in NSLog("This alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Quiz Subjects"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: customize here
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! SubjectTableViewCell
        cell.subjectTitle.text = subjects[index]
        cell.subjectDescription.text = descriptions[index]
        cell.imageView?.image = images[index]
        // cell.textLabel?.text = subject
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        subjectsTable.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

