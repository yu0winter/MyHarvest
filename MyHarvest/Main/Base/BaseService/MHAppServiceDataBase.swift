//
//  MHAppServiceDataBase.swift
//  MyHarvest
//
//  Created by NiuYulong on 2017/9/12.
//  Copyright © 2017年 NiuYulong. All rights reserved.
//

import UIKit
import RealmSwift

class MHAppServiceDataBase: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.setDefaultRealmForUser(username: "test")
        
        return true
    }
    
    
    func setDefaultRealmForUser(username: String) {
        
        var config = Realm.Configuration()
        
        // Use the default directory, but replace the filename with the username
        config.fileURL = config.fileURL!.deletingLastPathComponent()
            .appendingPathComponent("\(username).realm")
        
        print("realm fileURL:\(String(describing: config.fileURL))")
        
        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
}
