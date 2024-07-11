//
//  Logger.swift
//  github_users
//
//  Created by Pritam Biswas on 10.07.2024.
//

import Foundation

class Logger {
    static let shared = Logger()
    private let logFileName = "app.log"
    private let maxLogLines = 1000

    private init() {}

    func log(_ message: String, level: LogLevel) {
        let timestamp = getCurrentTimestamp()
        let logMessage = "[\(timestamp)][\(level.rawValue)] \(message)"
        
        #if DEBUG
        print("[\(level.rawValue)] \(message)")
        storeLog("[\(level.rawValue)] \(message)")
        #else
        if level == .error {
            storeLog("[\(level.rawValue)] \(message)")
        }
        #endif
    }

    private func storeLog(_ message: String) {
        let fileURL = getLogFileURL()
        
        var logContents = (try? String(contentsOf: fileURL)) ?? ""
        var logLines = logContents.split(separator: "\n").map(String.init)
        
        logLines.append(message)
        
        if logLines.count > maxLogLines {
            logLines.removeFirst(logLines.count - maxLogLines)
        }
        
        logContents = logLines.joined(separator: "\n")
        
        do {
            try logContents.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Failed to write log: \(error)")
        }
    }
    
    private func getLogFileURL() -> URL {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = urls[0]
        return documentsDirectory.appendingPathComponent(logFileName)
    }
    
    private func getCurrentTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return dateFormatter.string(from: Date())
    }
    
    func clearLogs() {
        let fileURL = getLogFileURL()
        
        do {
            try "".write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Failed to clear log file: \(error)")
        }
    }
    
    func retrieveLogs() -> String {
        let fileURL = getLogFileURL()
        return (try? String(contentsOf: fileURL)) ?? ""
    }
}

enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

