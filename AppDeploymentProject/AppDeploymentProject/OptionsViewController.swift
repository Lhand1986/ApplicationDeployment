//
//  OptionsViewController.swift
//  AppDeploymentProject
//
//  Created by Levi Hand on 6/7/16.
//  Copyright © 2016 Levi Hand. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class OptionsViewController: UIViewController, MCBrowserViewControllerDelegate, MCSessionDelegate, UITextFieldDelegate {

    @IBOutlet weak var sessionId: UITextField!
    @IBOutlet weak var deviceId: UITextField!
    @IBOutlet weak var instructorButton: UIButton!
    @IBOutlet weak var managerButton: UIButton!
    
    //Declare variables and constants here
    var deviceName: String!
    let alert = UIAlertController(title: "No Session ID", message: "Please enter at least a Session ID and press return to save in order to search for other users.", preferredStyle: UIAlertControllerStyle.Alert)
    let defaults = NSUserDefaults.standardUserDefaults()
    
    /* Multipeer Application building blocks */
    var peerID:MCPeerID! //Our device's ID or name as viewed by other devices "browsing" for a connection
    var session:MCSession! //The connection between devices
    var browser:MCBrowserViewController! //Prebuilt ViewController that searches for nearby advertisers
    var advertiser:MCAdvertiserAssistant! //Helps us easily advertise ourselves to nearby MCBrowsers
    
    //Setting a channel for the game connection
    var serviceID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up button outlines
        instructorButton.layer.borderWidth = 0.1
        instructorButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).CGColor
        managerButton.layer.borderWidth = 0.1
        managerButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).CGColor
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))

        // Do any additional setup after loading the view.
        
        //Set up our MC objects
        peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        
        //Use PeerID to set up a session
        session = MCSession(peer: peerID)
        //Tell the session to look for the necessary functions inside this class
        session.delegate = self
        
        setIdent()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - User Defined functions
    
    /*Create a toggle function that sets a value based on which button is selected, only allows one of the two to be 
     selected at one time, and changes the background color of the button on selection */
    func buttonToggle(sender: UIButton){
        sender.selected = !sender.selected
        UserSingleton.sharedInstance.userClass = sender.tag
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        deviceName = deviceId.text
        serviceID = sessionId.text
        return true
    }
    
    /* Function to call for the multiple instances necessary of the alert presentation */
    func alertShow() {
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /* Set up a function that will check to see if the session and id have been set, and if
     they have, to show the user by assigning those values to the text fields*/
    func setIdent() {
        guard let currentSession = defaults.valueForKey("sessionId") as? String else{
            return
        }
        guard let currentId = defaults.valueForKey("deviceId") as? String else{
            return
        }
        sessionId.text = currentSession
        deviceId.text = currentId
        
    }
    
    //Mark: User Defined IBActions
    
    @IBAction func managerButton(sender: UIButton){
        buttonToggle(sender)
    }
    
    @IBAction func instructorButton(sender: UIButton){
        buttonToggle(sender)
    }
    
    @IBAction func saveButton(sender: UIButton){
        guard let sessionText = sessionId.text else {
            alertShow()
            return
        }
        guard let deviceText = deviceId.text else {
            alertShow()
            return
        }
        defaults.setObject(sessionText, forKey: "sessionId")
        defaults.setObject(deviceText, forKey: "deviceId")
        
    }
    
    //Denote an action which will start the advertiser and pull up the browser if the user has entered a serviceID. If not, show an error message
    @IBAction func userConnect(sender: AnyObject) {
        if let roomID = serviceID {
            advertiser = MCAdvertiserAssistant(serviceType: roomID, discoveryInfo: nil, session: session)
            advertiser.start()
            browser = MCBrowserViewController(serviceType: roomID, session: session)
            browser.delegate = self
            self.presentViewController(browser, animated: true, completion: nil)
        } else {
            alertShow()
        }
    }
    
    //Mark: MCBrowserViewControllerDelegate Callbacks
    
    // Notifies the delegate, when the user taps the done button on the browser View Controller.
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController) {
        browserViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Notifies delegate that the user taps the cancel button on the browser View Controller.
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController) {
        browserViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //Mark: MCSessionDelegate Callbacks
    
    //Function that notifies when you have connected to another peer
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        dispatch_async(dispatch_get_main_queue(), {
            UserSingleton.sharedInstance.userConnected = true

        })
    }
    
    // Received data from remote peer. This also lets the program know that the opponent is ready, and that the game can start
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
    }
    
    // Received a byte stream from remote peer.
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    
    // Start receiving a resource from remote peer.
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {}
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {}

}
