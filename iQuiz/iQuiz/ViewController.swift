//
//  ViewController.swift
//  iQuiz
//
//  Created by Harshitha Akkaraju on 2/8/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

/*
 TODO
 * Store json to local storage
 * Use local storage when device is offline
 * Move settings to application settings
 */

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var json : [[String : Any]] = [[ : ]]
    var url = URL(string: "http://tednewardsandbox.site44.com/questions.json")
    var row : Int = -1
    
    @IBOutlet weak var subjectsTable: UITableView!
    let images : [UIImage] = [UIImage(named: "Science!")!, UIImage(named: "Marvel Super Heroes")!, UIImage(named: "Mathematics")!]
    
    // find the user's documents directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // obtain file path to write to directory
        let documentDir = getDocumentsDirectory()
        let filePath = documentDir.appendingPathComponent("data.json")
        let fileString = filePath.absoluteString
        
        // If network is available
        if Reachability.isConnectedToNetwork() {
            // set url in app settings
            let settings = UserDefaults.standard
            settings.set(self.url, forKey: "name_preference")
            settings.synchronize()
            
            // make the api request
            request(url: self.url!)
            subjectsTable.delegate = self
            subjectsTable.dataSource = self
            navigationItem.hidesBackButton = true
            self.subjectsTable.reloadData()
            
            // write quiz data to file
            (json as NSArray).write(toFile: fileString, atomically: true)
            self.subjectsTable.reloadData()
        } else {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // download JSON from site
    func request(url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                let alert = UIAlertController(title: "Invalid URL", message: "Please enter a valid URL", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            // make sure we got data in the response
            guard data != nil else { return }
            do {
                // specify an array as a decoding result
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String : Any]]
                self.json = jsonResponse
                DispatchQueue.main.async {
                    self.subjectsTable.reloadData()
                }
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.json.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let category = self.json[index] as [String : Any]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubjectTableViewCell
        cell.subjectTitle.text = category["title"] as? String
        cell.subjectDescription.text = category["desc"] as? String
        cell.imageView?.image = images[index]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.row = indexPath.row
        performSegue(withIdentifier: "QuestionsVC", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuestionsViewController {
            let category = self.json[row] as [String : Any]
            destination.category = category
        }
    }
}

