//
//  MUCollectionViewTest.swift
//  SwiftUITest
//
//  Created by Ma Jiancheng on 2022/1/30.
//

import SwiftUI

struct MUCollectionViewTest: View {
    var works: Binding<[Int]> {
        didSet {
            print("didset")
        }
    }
    var body: some View {
        MUGridView {
            1
        } numberOfItemsInSection: { section in
            section == 0 ? works.count : 1
        } cellForItemAt: { indexPath, collectionView in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            cell.backgroundColor = .orange
            return cell
        } sizeForItemAt: { indexPath in
            return CGSize(width: 50, height: 100)
        } columnCountForSection: { section in
            2
        } minimumColumnSpacingForSectionAt: { section in
            2
        } minimumInteritemSpacingForSectionAt: { section in
            15
        } regiserCells: { collectionView in
//            collectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.width(), height: UIScreen.height())
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
            collectionView.backgroundColor = .blue
            if works.count > 0 {
                collectionView.reloadData()
            }
        }

    }
}

//struct MUCollectionViewTest_Previews: PreviewProvider {
//    @State var works: [Int] =  [1, 2, 3, 4, 5]
//    static var previews: some View {
//        MUCollectionViewTest(works: $works)
//    }
//}
