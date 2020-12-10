//
//  TwoTableRelationController.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2020/12/10.
//  Copyright © 2020 mjc. All rights reserved.
//

import UIKit

class TwoTableRelationController: MMController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var t1: UITableView!
    @IBOutlet weak var t2: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        t1.register(UINib(nibName: "HoriCell", bundle: nil), forCellReuseIdentifier: "HoriCell")
        t2.register(UINib(nibName: "HoriCell", bundle: nil), forCellReuseIdentifier: "HoriCell")
        
        t1.reloadData()
        t2.reloadData()
        print(t1.contentSize)
        
        var size = t1.contentSize
        size.width = 2 * size.width
        t1.contentSize = size
        
        print(t1.contentSize)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10000
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HoriCell", for: indexPath) as! HoriCell
        cell.loadData(indexPath.row)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == t1 {
            t2.contentOffset = t1.contentOffset
        } else if scrollView == t2 {
            t1.contentOffset = t2.contentOffset
        }
    }

}
