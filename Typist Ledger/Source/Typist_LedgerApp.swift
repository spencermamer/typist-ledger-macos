//
//  Typist_LedgerApp.swift
//  Typist Ledger
//
//  Created by Spencer Mamer on 1/14/23.
//

import SwiftUI
import AppKit.NSAccessibility

@main
struct Typist_LedgerApp: App {
#if os(macOS)
    @Environment(\.openWindow) private var openWindow
#endif
    
    // MARK: Properties
    @AppStorage("logFilePath") var logFilePath: String = ""
    
    // MARK: Init Services
    private var permissionsService = PermissionsService()
    private let keymonitoringService = KeyMonitoringService()
    private let fileService = FileService()
    
// MARK: -
    
    init() {
        // 1. Check if log file path is set. If not, prompt user to select folder
        self.logFilePath = selectLogFolderIfNotDefined()
        let filePath = self.logFilePath + "/keystroke.txt"
        
        // 2. Setup file on FileService
        if !fileService.loadFile(pathURL: URL(filePath: filePath)) {
            print("Could not load file")
        }
        
        // Check whether accessibility permissions are enabled
        self.permissionsService.pollAccessibilityPrivileges()
        // 3. Start keystroke counting service
        startLogging()
    }
    
    // MARK: UI
    
    var body: some Scene {
        
        Settings {
            PermissionsView()
        }
        
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
    
    // MARK: Functions
    
    private func startLogging() {
        DispatchQueue.main.async { self.keymonitoringService.start(service: self.fileService) }
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
