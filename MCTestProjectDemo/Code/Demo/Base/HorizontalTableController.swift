//
//  HorizontalTableController.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2020/12/10.
//  Copyright © 2020 mjc. All rights reserved.
//

import UIKit

class HorizontalTableController: MMController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    lazy var scroll: UIScrollView = {
        let s = UIScrollView(frame: view.bounds)
        s.delegate = self
//        s.panGestureRecognizer.delegate = self
        return s
    }()
    
    lazy var table: UITableView = {
        let t = UITableView(frame: CGRect(x: 0, y: 0, width: 875, height: view.frame.size.height), style: .plain)
        t.register(UINib(nibName: "HoriCell", bundle: nil), forCellReuseIdentifier: "HoriCell")
        t.delegate = self
        t.dataSource = self
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scroll)
        scroll.addSubview(table)
        scroll.contentSize = CGSize(width: table.frame.size.width, height: table.frame.height)
        
        
        scroll.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            print("refresh")
            self?.table.reloadData()
            self?.scroll.mj_header.endRefreshing()
        })
        
        scroll.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            print("more")
            self?.table.reloadData()
            self?.scroll.mj_footer.endRefreshing()
        })
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
        if scroll == scrollView {
            let contentOffset = scrollView.contentOffset
            var frame = scroll.mj_header.frame
            frame.origin.x = contentOffset.x
            scroll.mj_header.frame = frame
            var footerFrame = scroll.mj_footer.frame
            footerFrame.origin.x = contentOffset.x
            scroll.mj_footer.frame = footerFrame
            
        }
    }
    
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if let gesture = gestureRecognizer as? UIPanGestureRecognizer {
//            let velocity = gesture.velocity(in: self.scroll)
//            print(velocity)
//            return false
//        }
//        return true
//    }
    
}
