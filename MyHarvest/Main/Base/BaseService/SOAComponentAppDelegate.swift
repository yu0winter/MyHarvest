//
//  SOAComponentAppDelegate.swift
//  MyHarvest
//
//  Created by NiuYulong on 2017/9/10.
//  Copyright © 2017年 NiuYulong. All rights reserved.
//

import UIKit

class SOAComponentAppDelegate: NSObject {
    
    static let sharedInstance = SOAComponentAppDelegate()
    
    //This (private) prevents others from using the default '()' initializer for this class.
    private override init() {
        super.init()
    }
    
    let services: [UIApplicationDelegate] = [
        MHAppService3rdSDK.sharedInstance,
        MHAppServiceLocation.sharedInstance,
        MHAppServiceLocalNotification.sharedInstance,
        MHAppServiceRemoteNotification.sharedInstance,
        MHAppServiceDataBase(),
        ]
    
}
