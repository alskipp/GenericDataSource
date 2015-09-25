//
//  DateOfBirth.swift
//  GenericDataSource
//
//  Created by Alan Skipp on 25/09/2015.
//  Copyright © 2015 Alan Skipp. All rights reserved.
//

import Foundation

struct DOB {
    static let dateFormatter: NSDateFormatter = {
        let f = NSDateFormatter()
        f.dateStyle = .MediumStyle
        return f
    }()
    
    let date: NSDate
    init(year: Int, month: Int, day: Int) {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        date = calendar.dateFromComponents(components)!
    }
}

extension DOB: CustomStringConvertible {
    var description: String {
        return DOB.dateFormatter.stringFromDate(date)
    }
}
