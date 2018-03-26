//
//  MHEditViewController.swift
//  MyHarvest
//
//  Created by NiuYulong on 2017/11/28.
//  Copyright © 2017年 NiuYulong. All rights reserved.
//

import UIKit

class MHEditViewController: UIViewController,UITextViewDelegate {
    
    var info : MHMessageInfo?
    public convenience init(info: MHMessageInfo?) {
        self.init()
        self.info = info;
    }
    
    var textView: UITextView = {
        let textView = UITextView.init(frame: CGRect.init(x: 0, y: 64, width: MHScreenWidth, height: MHScreenHeight - 64))
        textView.font = UIFont .systemFont(ofSize: 15)
        textView.textColor = UIColor.black
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "编辑"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "确定", style: .done, target: self, action: #selector(self.rightBarItemAction))
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.textView)
        self.textView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func rightBarItemAction() {
        print("\(#function)")
    }
    
    // MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
    
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
