//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Ma Jiancheng on 2022/1/27.
//

import SwiftUI

struct ContentView: View {
    let w: CGFloat = UIScreen.main.bounds.width
    @State var isPresented: Bool = false
    
    func test() {
        print("test...")
    }
    var body: some View {
        VStack {
            Text("Hello, world!")
                .onTapGesture {
                    isPresented = !isPresented
                }
                .actionSheet(isPresented: $isPresented) {
                    ActionSheet(
                                   title: Text("File Import"),
                                   message: Text("""
                                            Import
                                            """),
                                   buttons: [
                                       .destructive(Text("Import"),
                                                    action: test),
                                       .default(Text("拍照"), action: {
                                           
                                       }),
                                       .default(Text("相册"), action: {
                                           
                                       }),
                                       .cancel()
                                   ])
                }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    VStack{
                        Text("test")
                    }
                    .frame(width: w/2, height: 100)
                    .background(Color.red)
                    
                    VStack{}
                    .frame(width: w/2, height: 100)
                    .background(Color.orange)

                    VStack{}
                    .frame(width: w/2, height: 100)
                    .background(Color.green)
                }
                
            }
            .frame(width: w, height: 100)
            
            MUCollectionViewChangeDataTest()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
