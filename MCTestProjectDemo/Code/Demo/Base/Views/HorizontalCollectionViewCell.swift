//
//  HorizontalCollectionViewCell.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2020/12/10.
//  Copyright © 2020 mjc. All rights reserved.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var l1: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(_ title: String?) {
        l1.text = title
    }

}
