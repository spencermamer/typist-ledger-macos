//
//  KeyMonitoringService.swift
//  Typist Ledger
//
//  Created by Spencer Mamer on 1/14/23.
//

import Foundation
import SwiftUI
import AppKit

class KeyMonitoringService {
    var tickStrokes = 0
    var lastTickTime : Double = 0
    
    func start()  {
        print("Starting")
        NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
            let nextTick = floor(Date().timeIntervalSince1970)
            // Keep talying typing until 60 seconds of silence
            if nextTick - self.lastTickTime > 60 {
                self.lastTickTime = nextTick
                print("\(self.lastTickTime) - \(self.tickStrokes)")
                self.tickStrokes = 0;
            }
            self.tickStrokes += 1
            print(self.tickStrokes)
        }
    }
    
    private func logToFile() {
        
    }
    
    
}

