//
//  MUGridView.swift
//  ABCManager
//
//  Created by Ma Jiancheng on 2022/1/29.
//  Copyright © 2022 GymChina Inc. All rights reserved.
//

import SwiftUI


struct MUGridView: UIViewRepresentable {
    
    var numberOfSections: () -> (Int)
    var numberOfItemsInSection: (Int) -> (Int)
    var cellForItemAt: (IndexPath, UICollectionView) -> (UICollectionViewCell)
    var sizeForItemAt: (IndexPath) -> (CGSize)
    var columnCountForSection: (Int) -> (Int)
    var minimumColumnSpacingForSectionAt: (Int) -> (CGFloat)
    var minimumInteritemSpacingForSectionAt: (Int) -> (CGFloat)
    
    var regiserCells: (UICollectionView) -> ()
    
    init(sections numberOfSections: @escaping () -> (Int),
         numberOfItemsInSection: @escaping (Int) -> (Int),
         cellForItemAt: @escaping (IndexPath, UICollectionView) -> (UICollectionViewCell),
         sizeForItemAt: @escaping (IndexPath) -> (CGSize),
         columnCountForSection: @escaping (Int) -> (Int),
         minimumColumnSpacingForSectionAt: @escaping (Int) -> (CGFloat),
         minimumInteritemSpacingForSectionAt: @escaping (Int) -> (CGFloat),
         regiserCells: @escaping (UICollectionView) -> ()) {
        self.numberOfSections = numberOfSections
        self.numberOfItemsInSection = numberOfItemsInSection
        self.cellForItemAt = cellForItemAt
        self.sizeForItemAt = sizeForItemAt
        self.columnCountForSection = columnCountForSection
        self.minimumColumnSpacingForSectionAt = minimumColumnSpacingForSectionAt
        self.minimumInteritemSpacingForSectionAt = minimumInteritemSpacingForSectionAt
        self.regiserCells = regiserCells
    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = context.coordinator
        collectionView.dataSource = context.coordinator
        regiserCells(collectionView)
        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        
    }
    
    func makeCoordinator() -> MUGridCoordinator {
        MUGridCoordinator(self, numberOfSections: numberOfSections,
                          numberOfItemsInSection: numberOfItemsInSection,
                          cellForItemAt: cellForItemAt,
                          sizeForItemAt: sizeForItemAt,
                          columnCountForSection: columnCountForSection,
                          minimumColumnSpacingForSectionAt: minimumColumnSpacingForSectionAt,
                          minimumInteritemSpacingForSectionAt: minimumInteritemSpacingForSectionAt)
    }
    
    class MUGridCoordinator: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        var parent: MUGridView
        var numberOfSections: () -> (Int)
        var numberOfItemsInSection: (Int) -> (Int)
        var cellForItemAt: (IndexPath, UICollectionView) -> (UICollectionViewCell)
        var sizeForItemAt: (IndexPath) -> (CGSize)
        var columnCountForSection: (Int) -> (Int)
        var minimumColumnSpacingForSectionAt: (Int) -> (CGFloat)
        var minimumInteritemSpacingForSectionAt: (Int) -> (CGFloat)
        
        init(_ view: MUGridView,
             numberOfSections: @escaping () -> (Int),
             numberOfItemsInSection: @escaping (Int) -> (Int),
             cellForItemAt: @escaping (IndexPath, UICollectionView) -> (UICollectionViewCell),
             sizeForItemAt: @escaping (IndexPath) -> (CGSize),
             columnCountForSection: @escaping (Int) -> (Int),
             minimumColumnSpacingForSectionAt: @escaping (Int) -> (CGFloat),
             minimumInteritemSpacingForSectionAt: @escaping (Int) -> (CGFloat)) {
            self.parent = view
            self.numberOfSections = numberOfSections
            self.numberOfItemsInSection = numberOfItemsInSection
            self.cellForItemAt = cellForItemAt
            self.sizeForItemAt = sizeForItemAt
            self.columnCountForSection = columnCountForSection
            self.minimumColumnSpacingForSectionAt = minimumColumnSpacingForSectionAt
            self.minimumInteritemSpacingForSectionAt = minimumInteritemSpacingForSectionAt
            
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return numberOfSections()
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return numberOfItemsInSection(section)
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return cellForItemAt(indexPath, collectionView)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return sizeForItemAt(indexPath)
        }
        
        func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, columnCountForSection section: Int) -> Int {
            return columnCountForSection(section)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return minimumColumnSpacingForSectionAt(section)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return minimumInteritemSpacingForSectionAt(section)
        }
        
        
        
    }
}
