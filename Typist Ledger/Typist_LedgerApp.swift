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
    @State var currentNumber: String = "1"
    var keymonitoringservice = KeyMonitoringService()

    
//    private var filePath : String {
//        return self.logFilePath + "minlog.txt"
//    }
    
  var fileService = FileService()
#if os(macOS)
    @Environment(\.openWindow) private var openWindow
#endif
    
    init() {
        // 1. Check if log file path is set. If not, prompt user to select folder
        self.logFilePath = selectLogFolderIfNotDefined()
        print(self.logFilePath)
        let filePath = self.logFilePath + "/keystroke.txt"
        if !fileService.loadFile(pathURL: URL(filePath: filePath)) {
            print("Could not load file")
        }
        // 2. Init FileService
//         self.fileService = FileService(filePath: filePath)
        // call local function to handle fileservice starting
        
        // 3. Start serviceIt will check if file exists. Create directories as needed. Create file. If does exist, open file, seek to the end. return
        
        // Start keystroke counting service
        startLogging()
    }
    
   
    var body: some Scene {
        
    
        MenuBarExtra("Typist Ledger", systemImage: "keyboard.badge.ellipsis") {
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
        
    
    // MARK: - Functions
    private func fileManagerStart() {
        
        
        
    }
    private func startLogging() {
        DispatchQueue.main.async { self.keymonitoringservice.start(service: self.fileService) }
    }
    
    private func selectLogFolderIfNotDefined() -> String {
        if self.logFilePath.isEmpty {
            let selectURL = showSelectDirectoryPanel()
            if let selectedURL = selectURL {
                print("\(selectedURL.relativePath)")

               return selectedURL.relativePath
            }
        }
        return self.logFilePath
    }
    
    
    private func showSelectDirectoryPanel() -> URL? {
        let picker = NSOpenPanel()
        picker.canChooseFiles = false
        picker.canChooseDirectories = true
        picker.allowsMultipleSelection = false
        let response = picker.runModal()
        return response == .OK ? picker.url : nil
    }
    
    
    
}
