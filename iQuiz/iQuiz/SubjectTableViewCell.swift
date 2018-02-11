//
//  SubjectTableViewCell.swift
//  iQuiz
//
//  Created by Harshitha Akkaraju on 2/8/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import UIKit

class SubjectTableViewCell: UITableViewCell {

    @IBOutlet weak var subjectTitle: UILabel!
    @IBOutlet weak var subjectIcon: UIImageView!
    @IBOutlet weak var subjectDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
