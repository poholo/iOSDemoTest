//
//  SwiftListController.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2021/1/12.
//  Copyright © 2021 mjc. All rights reserved.
//

import UIKit

class SwiftListController: MMTableController {
    
    lazy var dataVM: SwiftListDataVM = SwiftListDataVM()

    required init!(routerParams params: MMDict!) {
        super.init(routerParams: params)
        title = "swift"
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tablecell")
        reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath)
        cell.textLabel?.text = dataVM.nm4row(indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        return SwiftListNode.sum.rawValue
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let node = SwiftListNode(rawValue: indexPath.row)!
        if node == .test {
            let test = SwiftTestController()
            navigationController?.pushViewController(test, animated: true)
        } else if node == .algorithm {
            let vc = AlgorithmController()
            navigationController?.pushViewController(vc, animated: true)
        } else if node == .type {
            let vc = SwiftTypeTestController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
