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
    
    var body: some Scene {

        MenuBarExtra("Typist Ledger", systemImage: "keyboard.badge.ellipsis") {
            Button("One") {
                currentNumber = "1"
            }
            Button("Two") {
                currentNumber = "2"
            }
            Button("Three") {
                currentNumber = "3"
            }
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
    }
}
