//
//  HorizontalTableConllectionController.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2020/12/10.
//  Copyright © 2020 mjc. All rights reserved.
//

import UIKit

class HorizontalTableConllectionController: MMController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var headerView: HorizontalMutilCell = {
        let headerView = Bundle.main.loadNibNamed("HorizontalMutilCell", owner: self, options: nil)?.first as! HorizontalMutilCell
        headerView.loadData(syncOffsetCallBack())
        headerView.backgroundColor = .blue
        return headerView
    } ()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    required init!(routerParams params: MMDict!) {
        super.init(routerParams: params)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HorizontalMutilCell", bundle: nil), forCellReuseIdentifier: "HorizontalMutilCell")
        tableView.reloadData()
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.tableView.mj_header.endRefreshing()
            
        })
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.tableView.mj_footer.endRefreshing()
        })
        /*
        let headerView = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        headerView.backgroundColor = .blue
        headerView.text = "headerview"
        tableView.tableHeaderView = headerView
         */
        
        tableView.tableHeaderView = headerView
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1500
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HorizontalMutilCell", for: indexPath) as! HorizontalMutilCell
        cell.loadData(syncOffsetCallBack())
        return cell
    }
    
    func syncOffsetCallBack() -> ((CGPoint, HorizontalMutilCell)->())? {
        return { [weak self] (point, currenCell) -> () in
            for cell in self?.tableView.visibleCells ?? [] {
                if cell == currenCell { continue }
                if let c = cell as? HorizontalMutilCell {
                    c.refreshContentOffset(point)
                }
            }
            if currenCell != self?.headerView {
                self?.headerView.refreshContentOffset(point)
            }
        }
    }


}
