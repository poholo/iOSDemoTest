//
//  SwiftListDataVM.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2021/1/12.
//  Copyright © 2021 mjc. All rights reserved.
//

import UIKit

enum SwiftListNode: Int {
    case test = 0, algorithm
}

class SwiftListDataVM: DataVM {
    func nm4row(_ row: Int) -> String?  {
        let node = SwiftListNode(rawValue: row)!
        switch node {
        case .test:
            return "test"
        case.algorithm:
            return "algorithm"
        default:
            return nil
        }
    }
}
