//
//  LogEntry.swift
//  WebSocketClient
//
//  Created by Hu, Hao on 13.06.18.
//  Copyright © 2018 Hao. All rights reserved.
//

import Cocoa

enum LogLevel: Int {
    
    case error = 0
    case warn
    case info
    case debug
    case trace
    
    static func parseString(string: String) -> LogLevel? {
        switch string {
        case "ERROR":
            return .error
        case "WARN":
            return .warn
        case "INFO":
            return .info
        case "DEBUG":
            return .debug
        case "TRACE":
            return .trace
        default:
            return nil
        }
    }
    
    var representation: String {
        switch self {
        case .debug:
            return "DEBUG"
        case .info:
            return "INFO"
        case .error:
            return "ERROR"
        case .trace:
            return "TRACE"
        case .warn:
            return "WARN"
        }
    }
    
    
    var color: NSColor {
        switch self {
            
        case .debug:
            return NSColor.white
        case .info:
            return NSColor(red:0.84, green:0.85, blue:0.86, alpha:1.00)
        case .error:
            return NSColor(red:0.95, green:0.59, blue:0.60, alpha:1.00)
        case .trace:
            return NSColor(red:0.54, green:0.67, blue:0.78, alpha:1.00)
        case .warn:
            return NSColor(red:0.96, green:0.81, blue:0.58, alpha:1.00)
            
        }
    }
}

struct LogEntry {
    
    var logLevel = LogLevel.debug
    var logContent:String = ""
    
    
    init(logString: String) {
        
        guard let jsonData = logString.data(using: .utf8) else {
            return
        }
        
        
        guard let jsonObj = try? JSONSerialization.jsonObject(with: jsonData, options: []) as! [String : String] else {
            return
        }
        
        
        self.logLevel = LogLevel.parseString(string: jsonObj["level"]!) ?? .debug
        self.logContent = jsonObj["body"]!
    }
}
