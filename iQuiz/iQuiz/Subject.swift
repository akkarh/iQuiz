//
//  Subject.swift
//  iQuiz
//
//  Created by Harshitha Akkaraju on 2/12/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import Foundation
import UIKit

class Subject {
    var subjectName: String
    var subjectDescription: String
    var subjectImage: UIImage
    
    init? (subject: String, description: String, image: UIImage) {
        if (subject == "" || description == "") {
            return nil
        }
        self.subjectName = subject
        self.subjectDescription = description
        self.subjectImage = image
    }
}
