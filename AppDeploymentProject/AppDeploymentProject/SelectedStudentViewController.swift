//
//  SelectedStudentViewController.swift
//  AppDeploymentProject
//
//  Created by Levi Hand on 6/8/16.
//  Copyright © 2016 Levi Hand. All rights reserved.
//

import UIKit

class SelectedStudentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var techniqueTable: UITableView!
    @IBOutlet weak var lessonsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var userTechniques = UserSingleton.sharedInstance.users
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTechnique(sender: UIButton) {
        
    }

    // MARK: Table View Functions
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //Instantiate a table view with custom cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SelectedStudentTableViewCell
        
        cell.techName.text = "Foo"
        cell.date.text = "Bar"
        
        return cell
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
