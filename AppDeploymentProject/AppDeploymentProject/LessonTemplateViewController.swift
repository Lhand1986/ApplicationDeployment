//
//  LessonTemplateViewController.swift
//  AppDeploymentProject
//
//  Created by Levi Hand on 6/8/16.
//  Copyright © 2016 Levi Hand. All rights reserved.
//

import UIKit

class LessonTemplateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    //Declaration of IBOutlets
    @IBOutlet weak var templateTableView : UITableView!
    
    //Declare variables and constants
    var dataArray: [TemplateItem] = []
    let alert = UIAlertController(title: "New Requirement", message: "Please input the title of the student requirement and then the displayed text.", preferredStyle: UIAlertControllerStyle.Alert)
    var inputTitle: UITextField!
    var inputTemplate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Set up the alert controller with text fields and actions here
        alert.addTextFieldWithConfigurationHandler(titleTextField)
        alert.addTextFieldWithConfigurationHandler(templateTextField)
        alert.addAction(UIAlertAction(title: "Add", style: .Default, handler: {action in self.addTemplate()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: {action in self.clearAlert()}))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - User Defined Functions
    
    
    //Declare two functions that will serve as the handlers for the alert text fields
    func titleTextField(textField: UITextField!){
        textField.placeholder = "Enter the title"
        inputTitle = textField
    }
    func templateTextField(textField: UITextField!){
        textField.placeholder = "Enter the template text"
        inputTemplate = textField
    }
    
    //Allow the user to add an item onto the displayed table view, updating the table view and adding the item to the array
    func addTemplate() {
        let mutableItem: TemplateItem = TemplateItem()
        mutableItem.title = inputTitle.text!
        mutableItem.templateText = inputTemplate.text!
        dataArray.append(mutableItem)
        templateTableView.reloadData()
        clearAlert()
    }
    
    func clearAlert() {
        inputTitle.text = ""
        inputTemplate.text = ""
    }
    
    func tableViewToggle() {
        templateTableView.editing = !templateTableView.editing
    }
    
    // MARK: - User Defined IBActions
    
    //Create an IBAction that allows the user to edit the objects onscreen for deletion
    @IBAction func deleteItem(sender: AnyObject){
        tableViewToggle()
    }
    
    /*Create an IBAction that allows a user to add a row to the table view, displaying a pop-up which will allow the user to enter
     information into a title field for display onscreen and a text field for what is displayed in the template */
    @IBAction func addItem(sender: AnyObject){
        self.presentViewController(alert, animated: true, completion: nil)
        print(alert.textFields!.first!)
    }
    
    
    // MARK: - Necessary Table View Functions
    
    //Loading necessary function to add rows to the table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataArray.count
    }
    
    //Loading necessary function to edit cells in table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : TemplateCell = tableView.dequeueReusableCellWithIdentifier("repeatingCell") as! TemplateCell
        
        //Creating a constant value to load the data array object
        let templateInfo : TemplateItem = dataArray[indexPath.row]
        
        //Assigning value to the title label
        cell.titleLabel!.text = templateInfo.title
        
        return cell
    }
    
    //Function used for commiting edits to the table view
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        //Removing the item from the list in the array
        
        // If this function is triggered by a delete
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            //Remove the item from my data array
            dataArray.removeAtIndex(indexPath.row)
            
            //Delete the row from the index path
            templateTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableViewToggle()
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
