//
//  PlanViewController.swift
//  AppDeploymentProject
//
//  Created by Levi Hand on 6/7/16.
//  Copyright © 2016 Levi Hand. All rights reserved.
//

import UIKit

class PlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var snapshotTableView: UITableView!
    @IBOutlet weak var scheduleTableView: UITableView!
    
    var userNames = UserSingleton.sharedInstance.users
    var printer: UIPrinter!
    var delegate: UIPrinterPickerControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snapshotTableView.dataSource = self
        snapshotTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Allow the print button to be able to select a printer for the print function
    @IBAction func printButton(sender: AnyObject) {
        let printController = UIPrinterPickerController.init(initiallySelectedPrinter: printer)
        printController.delegate = delegate
        printController.presentAnimated(true, completionHandler: nil)
        
    }
    //Set up the ability to define a saved printer in the user defaults
    func printerPickerControllerDidSelectPrinter(printerPickerController: UIPrinterPickerController) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let currentPrinter = String(printerPickerController.selectedPrinter)
        defaults.setObject(currentPrinter, forKey: "savedPrinter")
    }
//    var selectedPrinter: UIPrinter?
    

    // MARK: TableView datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = userNames.count
        return count
    }
    
    //Allow for two separate table views to be populated with different custom cell objects
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        
        if tableView == self.snapshotTableView {
            cell = tableView.dequeueReusableCellWithIdentifier("SnapshotCell", forIndexPath: indexPath) as! SnapshotCell
            cell.textLabel!.text = userNames[0].valueForKey("name") as? String

        }
        
        if tableView == self.scheduleTableView {
            cell = tableView.dequeueReusableCellWithIdentifier("ScheduleCell", forIndexPath: indexPath) as! ScheduleCell
            cell.textLabel!.text = "Bar"
        }
        
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    // MARK: TableView Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    // MARK: Print interaction controller
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
