//
//  FileService.swift
//  Typist Ledger
//
//  Created by Spencer Mamer on 1/14/23.
//

import Foundation
import AppKit

class FileService {
    
    var  filePath : String = ""
    private var fileConfirmed: Bool = false
    private var fileHandle : FileHandle?
    
    func loadFile(pathURL : URL) -> Bool {
        let path = pathURL.relativePath
        print(path)
        if !FileManager.default.fileExists(atPath: path) {
            
            // Create file if not alrady existing
            let fileCreated = FileManager.default.createFile(atPath: path, contents: nil)
            
            if !fileCreated {
                return false
            }
        } else {
            print("File exists already")
        }
        
        // Configure Service
        self.filePath = path
        self.fileConfirmed = true
        
        return true
    }
    
    func addEntry(tick: Double, keystrokesCount: Int) -> Bool {
        if !fileConfirmed { return false}
        let entryString = entryString(tick: tick, keystrokeCount: keystrokesCount) + "\n"
        
        do {
            // Create file handle
            if let fileHandle = FileHandle(forWritingAtPath: filePath) {
                defer {
                    // At end of function, close file
                    fileHandle.closeFile()
                }
                // Go to end of file
                fileHandle.seekToEndOfFile()
                
                // Convert entry string to data and write at end of file
                if let data = entryString.data(using: .utf8) {
                    try fileHandle.write(contentsOf: data)
                }
            }
            else {
                // If file doesn't exist, though this should have been confirmed, use write to create
                try entryString.write(toFile: filePath, atomically: true, encoding: .utf8)
            }
            
        } catch { print(error) }
        return true
    }
    
    // MARK: Helper
    
    /// Creates entry string formatted for log.txt from reported tick (time) and keystroke count
    /// - Parameters:
    ///   - tick: Reference tick time
    ///   - keystrokeCount: Total keystrokes in tick interval
    /// - Returns: String formatted for log file
    private func entryString(tick: Double, keystrokeCount: Int) -> String {
        // Strip decimal from tick
        let formattedTick = String(format: "%.0f", tick)
        
        return "\(formattedTick), \(keystrokeCount)"
    }
}
