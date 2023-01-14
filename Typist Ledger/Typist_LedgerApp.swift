//
//  Typist_LedgerApp.swift
//  Typist Ledger
//
//  Created by Spencer Mamer on 1/14/23.
//

import SwiftUI

@main
struct Typist_LedgerApp: App {
    @State var currentNumber: String = "1"
#if os(macOS)
    @Environment(\.openWindow) private var openWindow
#endif
    
    var body: some Scene {
        Settings {
            SettingsView()
        }
////
//        Window("Settings", id: "settings") {
//            SettingsView()
//        }
        
        MenuBarExtra("Typist Ledger", systemImage: "keyboard.badge.ellipsis") {
            Button("One") {
                currentNumber = "1"
            }
            Button("Two") {
                currentNumber = "2"
            }
            Button("Settings") {
                
                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                NSApp.activate(ignoringOtherApps: true)
            
            }
            
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
    }
}
