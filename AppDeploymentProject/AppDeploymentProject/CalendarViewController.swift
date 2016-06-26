//
//  CalendarViewController.swift
//  AppDeploymentProject
//
//  Created by Levi Hand on 6/7/16.
//  Copyright © 2016 Levi Hand. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionCalendar: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
//    let calendar = NSCalendar.currentCalendar()
    let calendar = CalendarData()
    
    //Declare variables that contain the width and height of the collection view for responsive design purposes
    var calendarWidth: Float!
    var calendarHeight: Float!
    var cellWidth: Float!
    var cellHeight: Float!
    var sectionsValue : Int = 5
    var itemsValue : Int = 7
    var monthCounter = 1
    var indexRow : Int!
    var indexSection : Int!

//    let unitFlags: NSCalendarUnit = [.Year, .Month, .Day]
    
    //Creating a variable to hold the index path of the selected Collection View Cell
    var selectedIndex : NSIndexPath? {
        didSet {
            var indexPaths = [NSIndexPath]()
            if selectedIndex != nil {
                indexPaths.append(selectedIndex!)
            }
            if oldValue != nil {
                indexPaths.append(oldValue!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting restrictions for the cell width/height to be programmatically reactive to the size of the screen
        calendarWidth = Float(self.collectionCalendar.frame.width)
        calendarHeight = Float(self.collectionCalendar.frame.height)
        setCellSize(0.08, height: 0.2)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - CollectionViewDataSource Protocols
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sectionsValue
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsValue
    }
    
    // Get the width and height of the window, and use that to make coded reactive constraints for the cells
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellReuse", forIndexPath: indexPath) as! CalendarCell
        
        let months = calendar.calculateLength()
        if monthCounter <= months {
            cell.dayLabel.text = String(monthCounter)
        } else {
            cell.dayLabel.text = ""
        }
        monthCounter+=1
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(CGFloat(cellWidth), CGFloat(cellHeight))
    }
    
    // MARK - CollectionViewDelegate Protocols
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        
//    }
    
    /*Allow the user to select a specific cell, saving the index value of that cell and providing user feedback */
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if selectedIndex == indexPath {
            let cell: UICollectionViewCell = collectionView.cellForItemAtIndexPath(selectedIndex!)!
            cell.contentView.backgroundColor = .whiteColor()
            selectedIndex = nil
        } else {
            selectedIndex = indexPath
            let cell: UICollectionViewCell = collectionView.cellForItemAtIndexPath(selectedIndex!)!
            cell.contentView.backgroundColor = .lightGrayColor()
        }
        return false
    }
    
    // MARK - User Defined Functions
    func setCellSize(width: Float, height: Float) {
        cellWidth = calendarWidth * width
        cellHeight = calendarHeight * height
    }
    
    // MARK - IBActions
    
    /* Create a case switch that will cause the calendar to resize based on the selection
     of the segmented control, and update on selection*/
    @IBAction func changeIndex(sender:UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            sectionsValue = 1
            itemsValue = 1
            setCellSize(0.6, height: 0.6)
            monthCounter = calendar.day
        case 1:
            sectionsValue = 1
            itemsValue = 7
            setCellSize(0.2, height: 0.35)
            monthCounter = calendar.day
        case 2:
            sectionsValue = 5
            itemsValue = 7
            setCellSize(0.08, height: 0.2)
            monthCounter = 1
        default:
            sectionsValue = 5
            itemsValue = 7
            setCellSize(0.08, height: 0.2)
            monthCounter = 1
        }
        collectionCalendar.reloadData()
    
    }
    
    @IBAction func shareButton(sender:UIButton) {
        if UserSingleton.sharedInstance.userConnected {
            
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
