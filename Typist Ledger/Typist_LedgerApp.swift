//
//  Typist_LedgerApp.swift
//  Typist Ledger
//
//  Created by Spencer Mamer on 1/14/23.
//

import SwiftUI
import AppKit.NSAccessibility
import Combine

@main
struct Typist_LedgerApp: App {
    @AppStorage("logFilePath") var logFilePath: String = ""
    
    @AppStorage("hasOnBoarded") var hasOnboarded = false
    
    @State var currentNumber: String = "1"
    let keymonitoringservice = KeyMonitoringService()
    let fileManager = FileManager.default
    var logFileHandle : FileHandle?
    var fileService : FileService?
#if os(macOS)
    @Environment(\.openWindow) private var openWindow
#endif
    
    init() {
        
        // Is a log path defined?
        
        // Create File
//       setupLogFile()
        selectLogFolderIfNotDefined()
//        self.fileWriter = File(filePath: self.logFilePath)
        startLogging()
        
    
        
        
    }
    func startLogging() {
        DispatchQueue.main.async { self.keymonitoringservice.start() }
    }
    private func selectLogFolderIfNotDefined() {
        if self.logFilePath.isEmpty {
            let selectURL = showSelectDirectoryPanel()
            if let selectedURL = selectURL {
                self.logFilePath = selectedURL.absoluteString
                print("\(self.logFilePath)")
            }
        }
        
    }
    
    private func setupLogFile() {
        selectLogFolderIfNotDefined()
//        let filepath = self.logFilePath + "minutelog.txt"
        
       
        
    }
    
    private func showSelectDirectoryPanel() -> URL? {
        let picker = NSOpenPanel()
        picker.canChooseFiles = false
        picker.canChooseDirectories = true
        picker.allowsMultipleSelection = false
        let response = picker.runModal()
        return response == .OK ? picker.url : nil
    }
    
    
    
    var body: some Scene {
        
      
        
        MenuBarExtra("Typist Ledger", systemImage: "keyboard.badge.ellipsis") {
            Button("One") {
            }
            Button("Two") {
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
