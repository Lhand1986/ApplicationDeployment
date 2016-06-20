//
//  UserSingleton.swift
//  AppDeploymentProject
//
//  Created by Levi Hand on 6/8/16.
//  Copyright © 2016 Levi Hand. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity

class UserSingleton: NSObject, MCBrowserViewControllerDelegate, MCSessionDelegate {
    
    static let sharedInstance = UserSingleton()
    
    var userClass: Int!
    
    var userConnected: Bool = false
    
    
    
    
    
}