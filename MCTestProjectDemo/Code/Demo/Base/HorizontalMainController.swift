//
//  HorizontalMainController.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2020/12/10.
//  Copyright © 2020 mjc. All rights reserved.
//

import UIKit

class HorizontalMainController: MMTopPageController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...10 {
            let vc = HorizontalTableController()
            vc.title = "Hori\(i)"
            pageViewControllers[i] = vc
        }
        reloadData()
        
        for i in 0...10 {
            if let vc = pageViewControllers[i] as? HorizontalTableController{
                print(vc.scroll.contentSize)
            }
        }
    }
    

}
