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
    internal struct Error: AnalyticsEvent {
        internal let eventType: String = "Playback.Error"
        internal let bufferLimit: Int64 = 3000
        internal let timestamp: Int64
        
        /// Offset in the video sequence where the playback was aborted.
        internal let offsetTime: Int64
        
        /// Human readable error message
        /// Example: "Unable to parse HLS manifest"
        internal let message: String
        
        /// Platform-dependent error code
        internal let code: Int
        
        internal init(timestamp: Int64, offsetTime: Int64, message: String, code: Int) {
            self.timestamp = timestamp
            self.offsetTime = offsetTime
            self.message = message
            self.code = code
        }
    }
}

extension Playback.Error: PlaybackOffset { }
extension Playback.Error {
    internal var jsonPayload: [String : Any] {
        return [
            JSONKeys.eventType.rawValue: eventType,
            JSONKeys.timestamp.rawValue: timestamp,
            JSONKeys.offsetTime.rawValue: offsetTime,
            JSONKeys.message.rawValue: message,
            JSONKeys.code.rawValue: code
        ]
    }
    
    internal enum JSONKeys: String {
        case eventType = "EventType"
        case timestamp = "Timestamp"
        case offsetTime = "OffsetTime"
        case message = "Message"
        case code = "Code"
    }
}
