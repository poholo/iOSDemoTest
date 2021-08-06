//
//  ScrollZoomController.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2021/8/2.
//  Copyright © 2021 mjc. All rights reserved.
//

import UIKit

class ScrollZoomController: MMTableController {
    required init!(routerParams params: MMDict!) {
        super.init(routerParams: params)
    }
    
    lazy var headerView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        return v
    }()
    
    lazy var headerImg: UIImageView =  UIImageView(image: UIImage(named: "timg.jpeg"))
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerImg.frame = headerView.frame
        headerImg.layer.borderWidth = 4
        headerImg.layer.borderColor = UIColor.red.cgColor
        headerView.addSubview(headerImg)
        tableView.register(UINib(nibName: "ScrollZoomCell", bundle: nil), forCellReuseIdentifier: "ScrollZoomCell")
        tableView.tableHeaderView = headerView
        tableView.reloadData()
    }
    

}
extension ScrollZoomController {
    override func tableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollZoomCell", for: indexPath) as! ScrollZoomCell
        cell.tLb.text = "test" + "\(indexPath.section) - " + "\(indexPath.row)"
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        print(y)
        if y < UIScreen.main.bounds.height - 100 {
            print("zoom")
            let h: CGFloat = UIScreen.main.bounds.height - y
            let f = headerImg.frame
            let hf = CGRect(x: 0, y: y, width: f.width, height: h)
            headerImg.frame = hf
            print(hf)
            print(headerImg.frame)
        }
        
    }
    
}
