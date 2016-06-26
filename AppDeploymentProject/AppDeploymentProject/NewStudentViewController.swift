//
//  NewStudentViewController.swift
//  AppDeploymentProject
//
//  Created by Levi Hand on 6/8/16.
//  Copyright © 2016 Levi Hand. All rights reserved.
//

import UIKit
import CoreData

class NewStudentViewController: UIViewController {

    /*Need to allow for this view controller to add data to our CoreData and re-update our current 
     coreData output in the user singleton on completion */
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lessonsTextField: UITextField!
    
    //Setting up core data functionality, here
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var newStudent: NSEntityDescription!
    let alert = UIAlertController(title: "Incorrect Entry", message: "Please enter an alphabetical name and a numeral number.", preferredStyle: UIAlertControllerStyle.Alert)
    let okButton = UIAlertAction(title: "Okay", style: .Cancel, handler: {action in })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alert.addAction(okButton)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Create functionality to add the student information to the CoreData, making certain that
     the optional text fields are properly handled with unwrapping and error handling*/
    @IBAction func addStudent(sender: AnyObject) {
        guard let nameText = nameTextField.text else {
            showAlert()
            return
        }
        guard let lessonsText = lessonsTextField.text else {
            showAlert()
            return
        }
        let possibleNumber = lessonsText ?? ""
        guard let convertedNumber = Int(possibleNumber) else {
            showAlert()
            return
        }
        saveStudent(nameText, lessons: convertedNumber)
        
    }
    
    func showAlert() {
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //Craft a function that allows the student information to be saved into core data
    func saveStudent(name: String, lessons: Int) {
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("Student", inManagedObjectContext: managedContext)
        let student = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        student.setValue(name, forKey: "name")
        student.setValue(lessons, forKey: "lessonsRemain")
        do {
            try managedContext.save()
            UserSingleton.sharedInstance.users.append(student)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
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
