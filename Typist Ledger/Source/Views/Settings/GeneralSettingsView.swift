//
//  GeneralSettingsView.swift
//  Typist Ledger
//
//  Created by Spencer Mamer on 1/21/23.
//

import SwiftUI

struct GeneralSettingsView: View {
    
    var body: some View {
        Text("General").font(.title)
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
        GeneralSettingsView()
    }
}
