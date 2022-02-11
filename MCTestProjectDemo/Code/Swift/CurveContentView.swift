//
//  CurveContentView.swift
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2022/1/27.
//  Copyright © 2022 mjc. All rights reserved.
//

import SwiftUI

struct MSegementItem: View {
    @State var name: String
    @State var index: Int
    @Binding var selectedIdx: Int
    var body: some View {
        Text(name)
            .font(.system(size: 16,weight: selectedIdx == index ? .medium : .light))
            .foregroundColor(selectedIdx == index ? .red : Color.black)
            .fixedSize()
            .onTapGesture {
                selectedIdx = index
            }
    }
}

struct CurveContentView: View {
    var w = UIScreen.main.bounds.width
    @State var selectIdx: Int = 0
    
    var body: some View {
        let segWidth: CGFloat = UIScreen.main.bounds.width / 3
        VStack {
            Path { path in
                let h1: CGFloat = 40
                path.move(to: .zero)
                path.addLine(to: .init(x: 0, y: h1))
                path.addQuadCurve(to: .init(x: w, y: h1), control: .init(x: w / 2, y: h1 + 80))
                
                path.addLine(to: .init(x: w, y: 0))
                path.addLine(to: .zero)
                path.closeSubpath()
            }
            .fill(Color.red)
            .clipped()
            
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    MSegementItem(name: "作品", index: 0, selectedIdx: $selectIdx)
                        .frame(width: segWidth)
                        .padding(.zero)
                        .background(Color.blue)
                    MSegementItem(name: "介绍", index: 1, selectedIdx: $selectIdx)
                        .frame(width: segWidth)
                        .padding(.zero)
                        .background(Color.orange)
                    MSegementItem(name: "证书", index: 2, selectedIdx: $selectIdx)
                        .frame(width: segWidth)
                        .padding(.zero)
                        .background(Color.purple)
                    
                }.frame(width: nil, height: 44, alignment: .center)
                
                Path { path in
                    path.addRect(.init(x: 0, y: 0, width: segWidth, height: 4))
                }
                .fill(Color.red)
                .offset(x: CGFloat(selectIdx) * segWidth, y: 0)
                
            }
            ScrollView {
                HStack{}.frame(width: segWidth, height: 2000, alignment: .center)
                    .background(Color.red)
            }
            .frame(width: UIScreen.main.bounds.width, height: 520, alignment: .center)
            .background(Color.orange)
            
            
            
        }
    }
}

struct CurveContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurveContentView(selectIdx: 0)
    }
}
