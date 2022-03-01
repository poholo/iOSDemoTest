//
//  MUCollectionViewControl.swift
//  SwiftUITest
//
//  Created by Ma Jiancheng on 2022/3/1.
//

import Foundation

struct MUCollectionViewControl {
    var photonms: [String] = ["a", "b", "c", "d"]
    func listPhotoUrls() async -> [String] {
        let purls = photonms.map { "http://baidu.com/" + $0 }
        NSLog("..before")
        sleep(2)
        
        NSLog("..end")
        return purls
    }
    
    func downloadPhoto(_ url: String) async -> String {
        NSLog("strat...download - %@", url)
        sleep(2)
        NSLog("finished...download - %@", url)
        return url + " finished"
    }
    
    func start() {
        Task {
            let photoUrls = await listPhotoUrls()
            NSLog("1. 获取到urls")
            for url in photoUrls {
                let result = await downloadPhoto(url)
                NSLog("2. download url - %@", result)
            }
        }
    }
    
    
}
