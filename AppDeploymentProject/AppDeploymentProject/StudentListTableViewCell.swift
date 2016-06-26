//
//  StudentListTableViewCell.swift
//  AppDeploymentProject
//
//  Created by Levi Hand on 6/23/16.
//  Copyright © 2016 Levi Hand. All rights reserved.
//

import UIKit

//Create a class to hold a bustom table view cell for the student list
class StudentListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var studentButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
