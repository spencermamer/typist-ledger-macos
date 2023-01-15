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
    var fileService : FileService?
    
    func start(service: FileService)  {
        self.fileService = service
        print("Starting")
        
        // Setup first interval
        self.lastTickTime = Date().timeIntervalSince1970
        
        NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
            let nextTick = Date().timeIntervalSince1970
        
            // Keep talying typing until 60 seconds of silence
            if floor(nextTick - self.lastTickTime) > 60 {
                
                // Interval reset. Last benchmark tick time set to now
                self.lastTickTime = nextTick
                
                print("\(self.lastTickTime) - \(self.tickStrokes)")
                
                print("Logged? \(self.logToFile(tick: self.lastTickTime, count: self.tickStrokes))")
                // Reset Keystrokes
                self.tickStrokes = 0;
            }
            self.tickStrokes += 1
            print(self.tickStrokes)
        }
    }
    
    private func logToFile(tick: Double, count: Int) -> Bool {
        if let fileService {
            return fileService.addEntry(tick: tick, keystrokesCount: count)
        }
        return false
    }
    
    
}

