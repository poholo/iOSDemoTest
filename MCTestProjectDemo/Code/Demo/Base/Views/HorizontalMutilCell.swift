//
//  HorizontalMutilCell.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2020/12/10.
//  Copyright © 2020 mjc. All rights reserved.
//

import UIKit

class HorizontalMutilCell: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
   
    @IBOutlet weak var collectionVw: UICollectionView!
    var callBack: ((CGPoint, HorizontalMutilCell)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionVw.delegate = self
        collectionVw.dataSource = self

        collectionVw.register(UINib(nibName: "HorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HorizontalCollectionViewCell")
    }
    
    func loadData(_ callBack: ((CGPoint, HorizontalMutilCell)->())?) {
        self.callBack = callBack
        collectionVw.reloadData()
    }
    
    func refreshContentOffset(_ offset: CGPoint) {
        if offset.x == collectionVw.contentOffset.x { return }
        collectionVw.contentOffset.x = offset.x
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCollectionViewCell", for: indexPath) as! HorizontalCollectionViewCell
        cell.loadData("Horizontal\(indexPath.row)")
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100 + indexPath.row, height: 44)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        callBack?(scrollView.contentOffset, self)
    }
    


    
}
