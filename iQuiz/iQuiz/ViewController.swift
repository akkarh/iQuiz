//
//  ViewController.swift
//  iQuiz
//
//  Created by Harshitha Akkaraju on 2/8/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let subjects : [String] = ["Math", "Science", "Marvel"]
    let descriptions : [String] = ["Do you have a knack for numbers?", "Test your mad science skills", "Do you know your marvel heros?"]
    let images : [UIImage] = [UIImage(named: "Math")!, UIImage(named: "Science")!, UIImage(named: "Marvel")!]
    var category : String = ""
    
    var jsonData : [[String : Any]] = [[:]]
    let url = URL(string: "http://tednewardsandbox.site44.com/questions.json")
    
    @IBOutlet weak var subjectsTable: UITableView!
    
    @IBAction func settings(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "click on check now to download quiz questions", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("check now", comment: "Default action"), style: .`default`, handler: getResults))
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: "Default action"), style: .`default`, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getResults(action: UIAlertAction) {
        if Reachability.isConnectedToNetwork(){
            request(url: self.url!)
        } else{
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .`default`, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func request(url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            guard error == nil else { return }
            // make sure we got data in the response
            guard let responseData = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as! [[String : Any]]
                self.jsonData = json
                print(json)
            } catch let error as NSError {
                let alert = UIAlertController(title: "Download Failed", message: "Unable to download questions.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .`default`, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }).resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: customize here
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubjectTableViewCell
        cell.subjectTitle.text = subjects[index]
        cell.subjectDescription.text = descriptions[index]
        cell.imageView?.image = images[index]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SubjectTableViewCell
        category = cell.subjectTitle.text!
        performSegue(withIdentifier: "QuestionsVC", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectsTable.delegate = self
        subjectsTable.dataSource = self
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuestionsViewController {
            destination.category = category
        }
    }
}

