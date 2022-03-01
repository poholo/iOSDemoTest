//
//  MUCollectionViewChangeDataTest.swift
//  SwiftUITest
//
//  Created by Ma Jiancheng on 2022/1/30.
//

import SwiftUI

struct MUCollectionViewChangeDataTest: View {
    @State var works: [Int] =  [1, 2, 3, 4, 5]
    var control = MUCollectionViewControl()
    var body: some View {
        MUCollectionViewTest(works: $works)
            .onHover(perform: { _ in
                works = [2, 5, 7]
                print("...")
            })
            .onTapGesture {
                if works.count == 3 {
                    works = [1, 2, 3, 4, 5]
                } else {
                    works = [2, 5, 7]
                }
                print("...")
            }
    }
    
    init() {
        control.start()
    }
}

struct MUCollectionViewChangeDataTest_Previews: PreviewProvider {
    static var previews: some View {
        MUCollectionViewChangeDataTest()
    }
}


