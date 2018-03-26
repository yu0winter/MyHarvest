//
//  MHHomeTableViewCell.swift
//  MyHarvest
//
//  Created by NiuYulong on 2017/11/28.
//  Copyright © 2017年 NiuYulong. All rights reserved.
//

import UIKit

class MHHomeTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 80, y: 13, width: MHScreenWidth - 110, height: 20))
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        return label
    }()
    var playBtn: MHPlayButton!
    var detailLabel: UILabel = {
       let label = UILabel.init(frame: CGRect.init(x: 80, y: 32, width: 60, height: 12))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        return label
    }()
    var starsView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 135, y: 30, width: 100, height: 10))
        view.backgroundColor = UIColor.red
        return view
    }()

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupContentViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupContentViews() {
        
        let view = self.contentView
        
        view.addSubview(titleLabel)
        view.addSubview(detailLabel)
        view.addSubview(starsView)
        
        
    }
    
}
