//
//  CustomCalendarCell.swift
//  AppDeploymentProject
//
//  Created by Levi Hand on 6/16/16.
//  Copyright © 2016 Levi Hand. All rights reserved.
//

import Foundation
import UIKit

class CalendarCell: UICollectionViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayView: UIView!
    
    var labelPosition: CGFloat!
    
    //Function that allows creation of a label inside the custom calendar cell when called
    func createLabel(appt: String){
        let dayHeight = CGFloat(dayView.bounds.size.height)
        let dayWidth = CGFloat(self.bounds.size.width)
        let label = UILabel()
        labelPosition = dayHeight
        label.frame = CGRectMake(6, (labelPosition), dayWidth, 30)
        label.backgroundColor = .brownColor()
        label.textColor = .blackColor()
        label.font = label.font.fontWithSize(10)
        label.textAlignment = .Left
        label.text = appt
        label.minimumScaleFactor = 0.1
        label.centerXAnchor
        label.centerYAnchor
        dayView.addSubview(label)
    }
    
    
}