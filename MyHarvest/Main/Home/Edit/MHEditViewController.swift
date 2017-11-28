//
//  MHEditViewController.swift
//  MyHarvest
//
//  Created by NiuYulong on 2017/11/28.
//  Copyright © 2017年 NiuYulong. All rights reserved.
//

import UIKit

class MHEditViewController: UIViewController {
    
    var info : MHMessageInfo?
    public convenience init(info: MHMessageInfo?) {
        self.init()
        self.info = info;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
