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
            
            print("File created? \(fileCreated)")
            if !fileCreated { return false }
        } else { print("File exists already") }
        
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
        return "\(tick),\(keystrokeCount)"
    }
    
    //    private func
    
    // MARK: -
    
    ///  Appends new line to log file with time of last record and # keystrokes
    /// - Parameters:
    ///   - tick: seconds since 1970
    ///   - strokes:  strokes in last minute
    //    func appendTicks(tick : Double, strokes : Int ) {
    //        if let handle = fileHandle {
    //            do {
    //                try handle.seekToEnd()
    //
    //            }
    //            catch {
    //                print(error)
    //                return
    //            }
    //            let string = "\(tick),\(strokes)"
    //            if let data = string.data(using: .utf8) {
    //                do { try handle.write(contentsOf: data) } catch { print(error.localizedDescription) }
    //            }
    //        }
    //    }
    //
    //
    //    /// Close and release file
    //    func close() {
    //        if let fileHandle {
    //            do { try fileHandle.close() } catch { print(error) }
    //        }
    //    }
    //
    
    
}
