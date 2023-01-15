//
//  FileService.swift
//  Typist Ledger
//
//  Created by Spencer Mamer on 1/14/23.
//

import Foundation
import AppKit

class FileService {
    
    let filePath : String
    let fileManager = FileManager.default
    let fileHandle : FileHandle?
    
    init(filePath: String) {
        self.filePath = filePath
        self.fileHandle = FileHandle(forWritingAtPath: filePath)
        
        do {
            try fileHandle?.seekToEnd()
        }
        catch {
            print(error)
        }
        
    }
    
    
    // MARK: -
    
    ///  Appends new line to log file with time of last record and # keystrokes
    /// - Parameters:
    ///   - tick: seconds since 1970
    ///   - strokes:  strokes in last minute
    func appendTicks(tick : Double, strokes : Int ) {
        if let handle = fileHandle {
            do {
                try handle.seekToEnd()
                
            }
            catch {
                print(error)
                return
            }
            let string = "\(tick),\(strokes)"
            if let data = string.data(using: .utf8) {
                do { try handle.write(contentsOf: data) } catch { print(error.localizedDescription) }
            }
        }
    }
    
    
    /// Close and release file
    func close() {
        if let fileHandle {
            do { try fileHandle.close() } catch { print(error) }
        }
    }
    

    
}
