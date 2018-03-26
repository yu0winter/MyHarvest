//
//  MHColorConfig.swift
//  MyHarvest
//
//  Created by NiuYulong on 2018/3/20.
//  Copyright © 2018年 NiuYulong. All rights reserved.
//

import Foundation




/// 默认透明度的随即色
///
/// - parameter R: red
/// - parameter G: green
/// - parameter B: blue
/// - parameter A: alpha
///
func MHColor(R:CGFloat,G:CGFloat,B:CGFloat,A:CGFloat) -> UIColor {
    return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha:A)
}


// swift 中不再有宏定义，而是使用let来代替
let MHMainDefaultColor = MHColor(R: 49, G: 48, B: 47, A: 1.0)
let MHMainSelectedColor = MHColor(R: 248, G: 69, B: 29, A: 1.0)


let MHScreenWidth = UIScreen.main.bounds.size.width
let MHScreenHeight = UIScreen.main.bounds.size.height
let MHNavigationBarHeight = UINavigationBar.appearance().frame.height
let MHStatusBarHeight = UIApplication.shared.statusBarFrame.size.height


let IsIPhoneX = (UIScreen.main.bounds.height == 812)
