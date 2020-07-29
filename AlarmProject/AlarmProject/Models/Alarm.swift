//
//  Alarm.swift
//  AlarmProject
//
//  Created by Ian Becker on 7/28/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation

class Alarm: Codable {
    
    var fireDate: Date
    var name: String
    var enabled: Bool
    var uuid: String
    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String = UUID().uuidString) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
    
    var fireTimeAsString: String {
        
        let date = DateFormatter()
    
        date.timeStyle = .short
    
        return date.string(from: fireDate)
        
    }
}//end of class

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        lhs.fireDate == rhs.fireDate && lhs.name == rhs.name && lhs.enabled == rhs.enabled && lhs.uuid == rhs.uuid
    }
}//end of extension
