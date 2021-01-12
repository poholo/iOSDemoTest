//
//  SwiftTestController.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2021/1/12.
//  Copyright © 2021 mjc. All rights reserved.
//

import UIKit

class Sessioin {
    static let shared: Sessioin = Sessioin()
    static var shared2: Sessioin = Sessioin()
    init() {
        print("session init")
    }

    func test() {
        print("test")
    }
}

class SwiftTestController: MMController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // shared static let var test
        Sessioin.shared.test()
        Sessioin.shared.test()
        
        
        Sessioin.shared2.test()
        Sessioin.shared2.test()
        
        // #if other swift flags 条件编译
        #if DEBUG
        print("DEBUG if")
        #else
        print("DEBUG else")
        #endif
        
    }


}
