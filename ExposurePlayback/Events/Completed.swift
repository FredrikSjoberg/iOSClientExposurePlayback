//
//  Completed.swift
//  Analytics
//
//  Created by Fredrik Sjöberg on 2017-07-17.
//  Copyright © 2017 emp. All rights reserved.
//


import Foundation
import Exposure

extension Playback {
    /// Playback stopped because it reached the end of the asset. If playback stopped due to user intervention or errors, a Playback.Aborted or Playback.Error should be sent instead.
    internal struct Completed {
        internal let timestamp: Int64
        
        /// Offset in the video sequence where the playback was stopped. This would typically be equal to the length of the asset in milliseconds.
        internal let offsetTime: Int64?
        
        internal init(timestamp: Int64, offsetTime: Int64?) {
            self.timestamp = timestamp
            self.offsetTime = offsetTime
        }
    }
}

extension Playback.Completed: AnalyticsEvent {
    var eventType: String {
        return "Playback.Completed"
    }
    
    var bufferLimit: Int64 {
        return 3000
    }
    
    internal var jsonPayload: [String : Any] {
        var json: [String: Any] = [
            JSONKeys.eventType.rawValue: eventType
        ]
        
        if timestamp > 0 {
            json[JSONKeys.timestamp.rawValue] = timestamp
        }
        
        if let value = offsetTime {
            json[JSONKeys.offsetTime.rawValue] = value
        }
        
        return json
    }
    
    internal enum JSONKeys: String {
        case eventType = "EventType"
        case timestamp = "Timestamp"
        case offsetTime = "OffsetTime"
    }
}
