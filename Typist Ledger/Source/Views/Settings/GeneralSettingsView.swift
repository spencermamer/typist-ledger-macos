//
//  GeneralSettingsView.swift
//  Typist Ledger
//
//  Created by Spencer Mamer on 1/21/23.
//

import SwiftUI

struct GeneralSettingsView: View {
    
    let fileService : FileService
    
    init(fileService: FileService) {
        self.fileService = fileService
    }
    
    var body: some View {
        Text("General").font(.title)
        Button("Change Log File") {
            let newLogFileURL = self.showFileSelectionDialogue()
            if let newLogFileURL {
                print("Loaded new log file: \(self.fileService.loadFile(pathURL: newLogFileURL))")
            }
            
        }
    }
    
    private func showFileSelectionDialogue() -> URL? {
        let picker = NSOpenPanel()
        picker.canChooseFiles = true
        picker.canChooseDirectories = true
        picker.allowsMultipleSelection = false
        picker.allowedContentTypes = [.plainText]
        
        let response = picker.runModal()
        return response == .OK ? picker.url : nil
    }
}

struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView(fileService: FileService())
    }
}




