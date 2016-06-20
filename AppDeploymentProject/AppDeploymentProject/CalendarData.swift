//
//  CalendarData.swift
//  AppDeploymentProject
//
//  Created by Levi Hand on 6/18/16.
//  Copyright © 2016 Levi Hand. All rights reserved.
//

import Foundation
import UIKit

class CalendarData {
    let calendar = NSCalendar.currentCalendar()
    
    let day = NSCalendar.currentCalendar().component(.Day, fromDate: NSDate())
    
    //Calculate the number of days in the current calendar month to populate the calendar with the appropriate number of days
    func calculateLength() -> Int {
        let year = calendar.component(.Year, fromDate: NSDate())
        let month = calendar.component(.Month, fromDate: NSDate())
        let dateCompile = NSDateComponents()
        dateCompile.year = year
        dateCompile.month = month
        let startDate = calendar.dateFromComponents(dateCompile)
        let dateRange = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: startDate!)
        let dateLength = dateRange.length
        return dateLength
    }
}