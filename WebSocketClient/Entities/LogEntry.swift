//
//  LogEntry.swift
//  WebSocketClient
//
//  Created by Hu, Hao on 13.06.18.
//  Copyright © 2018 Hao. All rights reserved.
//

import Cocoa

enum LogLevel: Int {
    case debug = 0
    case info
    case error
    
    
    var representation: String {
        switch self {
        case .debug:
            return "DEBUG"
        case .info:
            return "INFO"
        case .error:
            return "ERROR"
        }
    }
    
    
    var color: NSColor {
        switch self {
        case .debug:
            return NSColor.blue
        case .info:
            return NSColor.brown
        case .error:
            return NSColor.yellow
        }
    }
}

class LogEntry {
    
    var logLevel = LogLevel.debug
    var logContent:String
    
    
    init(logString: String) {
        self.logContent = logString
        let randomNum:UInt32 = arc4random_uniform(3)
        self.logLevel = LogLevel(rawValue: Int(randomNum))!
    }
}
