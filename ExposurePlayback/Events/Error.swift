//
//  Error.swift
//  Analytics
//
//  Created by Fredrik Sjöberg on 2017-07-17.
//  Copyright © 2017 emp. All rights reserved.
//

import Foundation
import Exposure

extension Playback {
    /// Playback stopped because of an error.
    internal struct Error {
        internal let timestamp: Int64
        
        /// Offset in the video sequence where the playback was aborted.
        internal let offsetTime: Int64?
        
        /// Human readable error message
        /// Example: "NOT_ENTITLED"
        internal let message: String
        
        /// Platform-dependent error code
        internal let code: Int
        
        /// Additional detailed error information
        internal let info: String?
        
        /// Error Details, such as stack trace or expanded error info
        internal let details: String?
        
        internal init(timestamp: Int64, offsetTime: Int64?, message: String, code: Int, info: String? = nil, details: String? = nil) {
            self.timestamp = timestamp
            self.offsetTime = offsetTime
            self.message = message
            self.code = code
            self.info = info
            self.details = details
        }
    }
}

extension Playback.Error: AnalyticsEvent {
    var eventType: String {
        return "Playback.Error"
    }
    
    var bufferLimit: Int64 {
        return 3000
    }
    
    internal var jsonPayload: [String : Any] {
        var json: [String: Any] = [
            JSONKeys.eventType.rawValue: eventType,
            JSONKeys.timestamp.rawValue: timestamp,
            JSONKeys.message.rawValue: message,
            JSONKeys.code.rawValue: code
        ]
        
        if let offset = offsetTime {
            json[JSONKeys.offsetTime.rawValue] = offset
        }
        
        if let info = info {
            json[JSONKeys.info.rawValue] = info
        }
        
        if let details = details {
            json[JSONKeys.details.rawValue] = details
        }
        
        return json
    }
    
    internal enum JSONKeys: String {
        case eventType = "EventType"
        case timestamp = "Timestamp"
        case offsetTime = "OffsetTime"
        case message = "Message"
        case code = "Code"
        case info = "Info"
        case details = "Details"
    }
}

