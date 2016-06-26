//
//  SelectedStudentTableViewCell.swift
//  AppDeploymentProject
//
//  Created by Levi Hand on 6/25/16.
//  Copyright © 2016 Levi Hand. All rights reserved.
//

import UIKit

//Create a custom cell for the selected student table view
class SelectedStudentTableViewCell: UITableViewCell {

    @IBOutlet weak var techName: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
