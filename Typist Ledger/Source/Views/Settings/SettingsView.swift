//
//  SettingsView.swift
//  Typist Ledger
//
//  Created by Spencer Mamer on 1/14/23.
//

import SwiftUI

struct SettingsView: View {
    
//    private enum Tabs: Hashable {
//        case general
//    }
    
    var body: some View {
        TabView {
            GeneralSettingsView().tabItem {
                Label("General", systemImage: "gear")
            }
            PermissionsView().tabItem {
                Label("Permissions", systemImage: "gear")
            }
        }.frame(minWidth: 450, minHeight: 400)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
