//
//  UserSingleton.swift
//  AppDeploymentProject
//
//  Created by Levi Hand on 6/8/16.
//  Copyright © 2016 Levi Hand. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UserSingleton {
    /*Allow information to be shared across the device, from one view controller to another utilizing a single 
     instance of this class */
    static let sharedInstance = UserSingleton()
    var userClass: Int!
    var userConnected: Bool = false
    var users: [NSManagedObject] = []
}