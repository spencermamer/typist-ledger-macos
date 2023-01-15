//
//  PermissionsService.swift
//  Typist Ledger
//
//  Created by Spencer Mamer on 1/15/23.
//

import Foundation
import AppKit

class PermissionsService {
    var isAccessibilityTrusted = AXIsProcessTrusted()
    
    func acquireAccesibilityPermission() {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        let _ = AXIsProcessTrustedWithOptions(options)
    }
    
    // Poll the accessibility state every 1 second to check
    //  and update the trust status.
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

