//
//  MHAppService3rdSDK.swift
//  MyHarvest
//
//  Created by NiuYulong on 2017/9/10.
//  Copyright © 2017 NiuYulong. All rights reserved.
//

import UIKit

class MHAppService3rdSDK: NSObject , UIApplicationDelegate {

    static var sharedInstance = MHAppService3rdSDK.init()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        print("注册三方库")
        return true
    }
}
