//
//  HorizontalTableCollectionMainController.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2020/12/10.
//  Copyright © 2020 mjc. All rights reserved.
//

import UIKit

class HorizontalTableCollectionMainController: MMTopPageController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        for i in 0...10 {
            let vc = HorizontalTableConllectionController()
            vc.title = "HTableCollection\(i)"
            pageViewControllers[i] = vc
        }
        reloadData()
    }

}
