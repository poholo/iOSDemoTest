
//
//  DouYinAnimationController.swift
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/9/3.
//  Copyright © 2019 mjc. All rights reserved.
//

import UIKit

class DouYinAnimationController: MMController {
    lazy var shareBtn: ShareButton = { () -> ShareButton in
        let btn = ShareButton(frame: CGRect(x: 100, y: 100, width: 45, height: 60))
        btn.addTarget(self, action: #selector(shareClick), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        self.view.addSubview(self.shareBtn)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.shareBtn.showFriendAniamtion()
        }
    }
    
    @objc func shareClick() {
        
    }

}
