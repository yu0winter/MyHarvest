//
//  MHHomeTableViewCell.swift
//  MyHarvest
//
//  Created by NiuYulong on 2017/11/28.
//  Copyright © 2017年 NiuYulong. All rights reserved.
//

import UIKit

class MHHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
