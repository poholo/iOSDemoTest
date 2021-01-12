//
//  ArtLikeAnimationController.swift
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/8/8.
//  Copyright © 2019 mjc. All rights reserved.
//

import Foundation

class ArtLikeAnimationController: MMController {
 
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init!(routerParams params: MMDict!) {
        super.init(routerParams: params)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ArtLikeAnimationController.click))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func click() {
        ArtLikeAnimationView.showLikeAniamtion(self.view)
    }
    
    
}
