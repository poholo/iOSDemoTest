//
//  GridView.swift
//  SwiftUITest
//
//  Created by Ma Jiancheng on 2022/3/17.
//

import SwiftUI

struct GridView: View {
    var gridItems = [GridItem(GridItem.Size.fixed(50), spacing: 10, alignment: .leading), GridItem(GridItem.Size.fixed(70), spacing: 10, alignment: .leading)]
    var body: some View {
        LazyVGrid(columns: gridItems) {
            Text("Hell0")
                .background(Color.red)
            Image("aaa")
                .resizable(capInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0), resizingMode: .stretch)
                .frame(width: 50, height: 50, alignment: .leading)
                .border(Color.red, width: 1)
            Text("Hell02").background(Color.gray)
            Text("Hell03").background(Color.orange)
            Text("Hell04").background(Color.blue)
        }
        
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
