//
//  HoriCell.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2020/12/9.
//  Copyright © 2020 mjc. All rights reserved.
//

import UIKit

class HoriCell: UITableViewCell {

    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var l4: UILabel!
    @IBOutlet weak var l5: UILabel!
    @IBOutlet weak var l6: UILabel!
    @IBOutlet weak var l7: UILabel!
    @IBOutlet weak var l8: UILabel!
    @IBOutlet weak var l9: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadData(_ index: Int) {
        l1.text = "Test\(index)-1"
        l2.text = "Test\(index)-2"
        l3.text = "Test\(index)-3"
        l4.text = "Test\(index)-4"
        l5.text = "Test\(index)-5"
        l6.text = "Test\(index)-6"
        l7.text = "Test\(index)-7"
        l8.text = "Test\(index)-8"
        l9.text = "Test\(index)-9"
    }
}
