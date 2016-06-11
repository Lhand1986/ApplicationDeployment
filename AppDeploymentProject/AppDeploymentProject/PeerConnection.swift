//
//  PeerConnection.swift
//  AppDeploymentProject
//
//  Created by Levi Hand on 6/9/16.
//  Copyright © 2016 Levi Hand. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Connection: MCBrowserViewControllerDelegate, MCSessionDelegate {
    
    
    
    /* Multipeer Application building blocks */
    var peerID:MCPeerID! //Our device's ID or name as viewed by other devices "browsing" for a connection
    var session:MCSession! //The connection between devices
    var browser:MCBrowserViewController! //Prebuilt ViewController that searches for nearby advertisers
    var advertiser:MCAdvertiserAssistant! //Helps us easily advertise ourselves to nearby MCBrowsers
    
    //Setting a channel for the game connection
    let serviceID: String = "MultiPeerGame"
    
    
    /* Put this under viewDidLoad
    
    //Set up our MC objects
    peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
    
    //Use PeerID to set up a session
    session = MCSession(peer: peerID)
    //Tell the session to look for the necessary functions inside this class
    session.delegate = self
    
    //Set up and start advertising immediately
    advertiser = MCAdvertiserAssistant(serviceType: serviceID, discoveryInfo: nil, session: session)
    advertiser.start()
 
 */
    
    
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
    @objc func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        dispatch_async(dispatch_get_main_queue(), {
            if state == MCSessionState.Connected {
                if session.connectedPeers.count >= 1 {
                    /*self.navItem.title = "Status: Connected to " + peerID.displayName
                    self.playButton.hidden = false*/
                }
            /*} else if state == MCSessionState.Connecting {
                self.navItem.title = "Status: Connecting..."
            } else if state == MCSessionState.NotConnected {
                self.navItem.title = "Status: No Connection"
                self.playButton.hidden = true
            }*/
            }
        })
    }
    
    // Received data from remote peer. This also lets the program know that the opponent is ready, and that the game can start
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        //Build a string from the received NSData object
        if let incomingData:String = String(data: data, encoding: NSUTF8StringEncoding) {/*
            opponentSelection = incomingData
            if opponentSelection == "Ready" {
                opponentReady = true
            }
            readyCheck()*/
        }
    }
    
    // Received a byte stream from remote peer.
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    
    // Start receiving a resource from remote peer.
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {}
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {}
}

