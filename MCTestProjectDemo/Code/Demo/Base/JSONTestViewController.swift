//
//  JSONTestViewController.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2020/12/12.
//  Copyright © 2020 mjc. All rights reserved.
//

import UIKit


class JSONAdapter  {
    class func data(from obj: Any) -> Data? {
        if JSONSerialization.isValidJSONObject(obj) {
            guard let data = try? JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted) else {
                return nil
            }
            return data
        }
        return nil
    }
    
    class func string(from obj: Any) -> String? {
        if let data = data(from: obj) {
            return String(data: data, encoding: .utf8)
        }
        return nil
        
    }
}
extension String {
    func mutableJsonObject() -> Any? {
        if let data = data(using: .utf8) {
            return data.mutableJsonObject()
        }
        return nil
    }
    
    func jsonObject() -> Any? {
        if let data = data(using: .utf8) {
            return data.jsonObject()
        }
        return nil
    }
}

extension Data {
    func mutableJsonObject() -> Any? {
        return __jsonObject(.mutableContainers)
    }
    
    func jsonObject() -> Any? {
        return __jsonObject(.allowFragments)
    }
    
    private func __jsonObject(_ options: JSONSerialization.ReadingOptions = []) -> Any? {
        guard let obj = try? JSONSerialization.jsonObject(with: self, options: options) else {
            return nil
        }
        return obj
    }
    
    func jsonString() -> String? {
        return JSONAdapter.string(from: self)
    }
}

extension Array {
    func jsonObject() -> [Any]? {
        if let data = JSONAdapter.data(from: self) {
            return data.mutableJsonObject() as? [Any]
        }
        return nil
    }
    
    func jsonString() -> String? {
        return JSONAdapter.string(from: self)
    }
}

extension Dictionary {
    func jsonObject() -> [AnyHashable: Any]? {
        if let data = JSONAdapter.data(from: self) {
            return data.mutableJsonObject() as? [AnyHashable: Any]
        }
        return nil
    }
    
    func jsonString() -> String? {
        return JSONAdapter.string(from: self)
    }
}


class JSONTestViewController: MMController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = "[\"a\", \"b\"]".data(using: .utf8)
        guard let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) else {
            return
        }
        print(json)
        print(json is Array<Any>)
        
        let data1 = "{\"a\": 1, \"b\": 2 }".data(using: .utf8)
        guard let json1 = try? JSONSerialization.jsonObject(with: data1!, options: .mutableContainers) else {
            return
        }
        print("json1\n")
        print(json1)
        print(json1 is Dictionary<String, Any>)
        
        let array = ["a1", "b1", "c1", 1] as [Any]
        guard  let dataArray = try? JSONSerialization.data(withJSONObject: array, options: .prettyPrinted),
               let json2 = try? JSONSerialization.jsonObject(with: dataArray, options: .mutableContainers) else {
            return
        }
        print(json2)
        
        print(">>>>>>>>>>>>>>>JSONAdapter------TEST")
        print((["xxxx", "bbbb", "222", 20202, "~~~~"] as [Any]).jsonString() ?? "-")
        print((["a": "b", "b": 1, "c": 5] as [AnyHashable: Any]).jsonString() ?? "-")
        
        
    }

}
