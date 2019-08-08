//
//  AlgorithmController.swift
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/7/23.
//  Copyright © 2019 mjc. All rights reserved.
//

import Foundation


class AlgorithmController: MMController {
    
    override func viewDidLoad() {
        
        let l1 = ListNode(2)
        l1.next = ListNode(4)
        l1.next!.next = ListNode(3)
        
        
        let l2 = ListNode(5)
        l2.next = ListNode(6)
        l2.next!.next = ListNode(4)
        
        
        let l3 = addTwoNumbers(l1, l2)
        print(l3?.val)
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var result: ListNode?
        var l1cursor: ListNode? = l1
        var l2cursor: ListNode? = l2
        var rcursor: ListNode?
        
        while l1cursor != nil {
            if result != nil {
                rcursor!.next = ListNode(l1cursor!.val + l2cursor!.val)
                rcursor = rcursor?.next
            } else {
                result = ListNode(l1cursor!.val + l2cursor!.val)
                rcursor = result
            }
            l1cursor = l1cursor!.next
            l2cursor = l2cursor!.next
        }
        return result
    }
}



public class ListNode {
    public var val: Int!
    public var next: ListNode?
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
