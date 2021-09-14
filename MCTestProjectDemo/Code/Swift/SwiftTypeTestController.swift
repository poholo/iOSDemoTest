//
//  SwiftTypeTestController.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2021/8/6.
//  Copyright © 2021 mjc. All rights reserved.
//

import UIKit

class Test: Any {
    required init() {
        
    }
}

class TestA: Test {
    
}

class TestB: Test {

}


class SwiftTypeTestController: UIViewController {
    let usingVCTypes: [AnyClass] = [TestA.self, TestB.self]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        for type in usingVCTypes {
//            if let vc = (type as! Test.Type).init() {
//                print(vc)
//            }
//        }
    }
    

}
