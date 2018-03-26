//
//  AppDelegate.swift
//  MyHarvest
//
//  Created by NiuYulong on 2017/9/2.
//  Copyright © 2017年 NiuYulong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        for service in SOAComponentAppDelegate.sharedInstance.services {
            _ = service.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        let tabBarController = self.customizedTabController()
        
        let navi = UINavigationController.init(rootViewController: tabBarController)
        self.window?.rootViewController = navi
        
        return true
    }
    
    func customizedTabController() -> UITabBarController {
        
        
        let homeVC = MHHomeViewController.init()
        homeVC.view.backgroundColor = UIColor.yellow
        let harvestVC = MHHarvestViewController.init()
        harvestVC.view.backgroundColor = UIColor.red
        let mineVC = MHMineViewController.init()
        mineVC.view.backgroundColor = UIColor.green
        
        
        let tabBarController = UITabBarController.init()
        tabBarController.setViewControllers([homeVC,harvestVC,mineVC], animated: false)
        // 设置item icon 的选中颜色
        tabBarController.tabBar.tintColor = MHMainSelectedColor
        var images = ["toolbar_today","toolbar_tover","toolbar_my"]
        for i:Int in 0..<tabBarController.tabBar.items!.count {
            let item = tabBarController.tabBar.items![i]
            // 设置图片绘制颜色为自动模式。即，选中状态使用tintColor,未选中使用图片原始颜色
            item.image = UIImage.init(named: images[i])?.withRenderingMode(.automatic)
            item.setTitleTextAttributes([NSForegroundColorAttributeName : MHMainDefaultColor], for: .normal)
            item.setTitleTextAttributes([NSForegroundColorAttributeName : MHMainSelectedColor], for: .selected)
        }
        return tabBarController
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

