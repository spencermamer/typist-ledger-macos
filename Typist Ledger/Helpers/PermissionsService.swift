//
//  PermissionsService.swift
//  Typist Ledger
//
//  Created by Spencer Mamer on 1/15/23.
//

import Foundation
import AppKit

final class PermissionsService {
    
    var isAccessibilityTrusted = AXIsProcessTrusted()
    
    
    /// Request accessibility permissions, this should prompt macOS to open and present the required dialogue open to the correct page for the user to just hit the add button.
    static func acquireAccesibilityPermission() {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        let _ = AXIsProcessTrustedWithOptions(options)
    }
    
  
    /// Poll the accessibility state every 1 second to check and update trust status
    func pollAccessibilityPrivileges() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isAccessibilityTrusted = AXIsProcessTrusted()
            print("Has access. privs? \(self.isAccessibilityTrusted)")
            
            if !self.isAccessibilityTrusted {
                self.pollAccessibilityPrivileges()
            }
        }
    }
}

