//
//  SettingView.swift
//  SwiftUITest
//
//  Created by Ma Jiancheng on 2022/3/28.
//

import SwiftUI

struct Setting: Identifiable {
    var id: String {
        nm
    }
    var nm: String
    var isOn: Bool
}



struct SettingView: View {
    @State var settings: [Setting]
    @State var isShuffling: Bool = false
    @State var isRepeating: Bool = false
    @State var isEnhanced: Bool = true
    var body: some View {
        VStack {
            List($settings) { $setting in
                Toggle(setting.nm, isOn: $setting.isOn)
                #if os(macOS)
                    .toggleStyle(.checkbox)
                #else
                    .toggleStyle(.switch)
                #endif
            }
            Label {
                Text("aaa")
                Text("bbbb")
            } icon: {
                Image(systemName: "person")
            }
            
            HStack {
                Toggle(isOn: $isShuffling) {
                    Label("Shuffle", systemImage: "shuffle")
                }
                Toggle(isOn: $isRepeating) {
                    Label("Repeat", systemImage: "repeat")
                }
            
                Divider()
            
                Toggle("Enhance Sound", isOn: $isEnhanced)
                    .toggleStyle(.automatic) // Set the style automatically here.
            }
            .toggleStyle(.button) // Use button style for toggles in the stack.

        }
    }
    
    init() {
        settings = [Setting(nm: "aaa", isOn: false),
                    Setting(nm: "bbb", isOn: false),
                    Setting(nm: "ccc", isOn: false),
                    Setting(nm: "ddd", isOn: false),
                    Setting(nm: "eee", isOn: false),
                    Setting(nm: "fff", isOn: false)]
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
