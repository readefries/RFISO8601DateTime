//
//  RFISO8601DateTimeTests.swift
//  RFISO8601DateTimeTests
//
//  Created by Hindrik Bruinsma on 21/01/16.
//  Copyright © 2016 xs4some. All rights reserved.
//

import XCTest

@testable import RFISO8601DateTime

class ISO8601DateTimeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInvalidDate() {
        let invalidDate = "invalidDate"
        
        XCTAssertNil(NSDate.parseDateString(invalidDate))
    }
    
    func testCalendarMonth() {
        let calendarMonth = "2016-01"
        
        let parsedDate = NSDate.parseDateString(calendarMonth)
        
        XCTAssertNotNil(parsedDate, "Date should not be nil")
        
        if parsedDate != nil {
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Month , .Year], fromDate: parsedDate)
            
            XCTAssertTrue(components.year == 2016, String(format: "The year should be 2016, not %d", components.year))
            XCTAssertTrue(components.month == 1, String(format: "The month should be 1, not %d", components.month))
        }
    }
    
    func testCalendarDate() {
        let calendarMonth = "2016-01-21"
        
        let parsedDate = NSDate.parseDateString(calendarMonth)
        
        XCTAssertNotNil(parsedDate, "Date should not be nil")
        
        if parsedDate != nil {
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Day , .Month , .Year], fromDate: parsedDate)
            
            XCTAssertTrue(components.year == 2016, String(format: "The year should be 2016, not %d", components.year))
            XCTAssertTrue(components.month == 1, String(format: "The month should be 1, not %d", components.month))
            XCTAssertTrue(components.day == 21, String(format: "The day should be 21, not %d", components.day))
        }
    }
    
    func testOrdinalDate() {
        let ordinalDate = "2016-021"
        
        let parsedDate = NSDate.parseDateString(ordinalDate)
        
        XCTAssertNotNil(parsedDate, "Date should not be nil")
        
        if parsedDate != nil {
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Year], fromDate: parsedDate)
            let day = calendar.ordinalityOfUnit(.Day, inUnit: .Year, forDate: parsedDate)
            
            XCTAssertTrue(components.year == 2016, String(format: "The year should be 2016, not %d", components.year))
            XCTAssertTrue(day == 21, String(format: "The day should be 21, not %d", day))
        }
    }
    
    func testWeekDate() {
        let weekDate = "2016-W03-6"
        
        let parsedDate = NSDate.parseDateString(weekDate)
        
        XCTAssertNotNil(parsedDate, "Date should not be nil")
        
        if parsedDate != nil {
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.WeekOfYear, .Weekday, .Year], fromDate: parsedDate)
            
            XCTAssertTrue(components.year == 2016, String(format: "The year should be 2016, not %d", components.year))
            XCTAssertTrue(components.weekOfYear == 3, String(format: "The week of the year should be 3, not %d", components.weekOfYear))
            XCTAssertTrue(components.weekday == 6, String(format: "The day of the week should be 6, not %d", components.weekday))
        }
    }
    
    func testWeekOfTheYear() {
        let weekOfTheYear = "2016-W03"
        
        let parsedDate = NSDate.parseDateString(weekOfTheYear)
        
        XCTAssertNotNil(parsedDate, "Date should not be nil")
        
        if parsedDate != nil {
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.WeekOfYear , .Year], fromDate: parsedDate)
            
            XCTAssertTrue(components.year == 2016, String(format: "The year should be 2016, not %d", components.year))
            XCTAssertTrue(components.weekOfYear == 3, String(format: "The week of the year should be 3, not %d", components.weekOfYear))
        }
    }
    
    func testTimeWithFractionalSecondsAndTimezone() {
        let time = "01:45:36.123+07:00"
        
        let parsedDate = NSDate.parseDateString(time)
        
        XCTAssertNotNil(parsedDate, "Date should not be nil")
        
        if parsedDate != nil {
            
            let timeZone = NSTimeZone.timeZoneWithString(time)
            
            XCTAssertNotNil(time, "timezone should not be nil")
            
            if timeZone != nil {
                
                let calendar = NSCalendar.currentCalendar()
                calendar.timeZone = timeZone
                let components = calendar.components([.Hour, .Minute, .Second, .Nanosecond, .TimeZone], fromDate: parsedDate)
                
                XCTAssertTrue(components.hour == 1, String(format: "The hour should be 1, not %d", components.hour))
                XCTAssertTrue(components.minute == 45, String(format: "The minute should be 45, not %d", components.minute))
                XCTAssertTrue(components.second == 36, String(format: "The seconde should be 36, not %d", components.second))
                XCTAssertTrue(components.nanosecond == 123001098, String(format: "the nanosecond should be 123001098, not %d", components.nanosecond))
                XCTAssertTrue(components.timeZone! == NSTimeZone(forSecondsFromGMT: 3600*7), String(format: "Timezone should be 'GMT+7:00', not %@", components.timeZone!))
            }
        }
    }
    
    func testTimeWithFractionalSeconds() {
        let time = "01:45:36.123"
        
        let parsedDate = NSDate.parseDateString(time)
        
        XCTAssertNotNil(parsedDate, "Date should not be nil")
        
        if parsedDate != nil {
            let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            
            let components = calendar.components([.Hour, .Minute, .Second, .Nanosecond], fromDate: parsedDate)
            
            XCTAssertTrue(components.hour == 1, String(format: "The hour should be 1, not %d", components.hour))
            XCTAssertTrue(components.minute == 45, String(format: "The minute should be 45, not %d", components.minute))
            XCTAssertTrue(components.second == 36, String(format: "The seconde should be 36, not %d", components.second))
            XCTAssertTrue(components.nanosecond/100000 == 1230, String(format: "the nanosecond should be 1230, not %d", components.nanosecond/100000))
        }
    }
    
    func testHoursMinutesAndSeconds() {
        let time = "10:10:13"
        
        let parsedDate = NSDate.parseDateString(time)
        
        XCTAssertNotNil(parsedDate, "Date should not be nil")
        
        if parsedDate != nil {
            let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            
            let components = calendar.components([.Hour, .Minute, .Second], fromDate: parsedDate)
            
            XCTAssertTrue(components.hour == 10, String(format: "The hour should be 10, not %d", components.hour))
            XCTAssertTrue(components.minute == 10, String(format: "The minute should be 10, not %d", components.minute))
            XCTAssertTrue(components.second == 13, String(format: "The seconde should be 13, not %d", components.second))
        }
    }
    
    func testHoursMinutes() {
        let time = "17:58"
        
        let parsedDate = NSDate.parseDateString(time)
        
        XCTAssertNotNil(parsedDate, "Date should not be nil")
        
        if parsedDate != nil {
            let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            
            let components = calendar.components([.Hour, .Minute], fromDate: parsedDate)
            
            XCTAssertTrue(components.hour == 17, String(format: "The hour should be 17, not %d", components.hour))
            XCTAssertTrue(components.minute == 58, String(format: "The minute should be 58, not %d", components.minute))
        }
    }
    
    func testTimeZoneDesignator() {
        //        Z, +01 or +01:00
        let timeZoneDesignatorZ = "Z"
        
        let parsedTimeZoneDesignatorZ = NSTimeZone.timeZoneWithString(timeZoneDesignatorZ)
        
        XCTAssertNotNil(parsedTimeZoneDesignatorZ, "Date should not be nil")
        
        if parsedTimeZoneDesignatorZ != nil {
            XCTAssertTrue(parsedTimeZoneDesignatorZ == NSTimeZone(forSecondsFromGMT: 0), String(format: "Timezone should be Z, not %@", parsedTimeZoneDesignatorZ!))
        }
        
        let timeZonePossitiveWithMinutes = "+05:30" // India
        
        let parsedTimeZoneDesignatorWithMinutes = NSTimeZone.timeZoneWithString(timeZonePossitiveWithMinutes)
        
        XCTAssertNotNil(parsedTimeZoneDesignatorWithMinutes, "Date should not be nil")
        
        if parsedTimeZoneDesignatorWithMinutes != nil {
            XCTAssertTrue(parsedTimeZoneDesignatorWithMinutes == NSTimeZone(forSecondsFromGMT: ((3600 * 5) + (30 * 60))), String(format: "Timezone should be +5:30, not %@", parsedTimeZoneDesignatorWithMinutes!))
        }
        
        let timeZoneNegativeWithoutMinutes = "-07" // India
        
        let parsedTimeZoneDesignatorWithoutMinutes = NSTimeZone.timeZoneWithString(timeZoneNegativeWithoutMinutes)
        
        XCTAssertNotNil(parsedTimeZoneDesignatorWithoutMinutes, "Date should not be nil")
        
        if parsedTimeZoneDesignatorWithoutMinutes != nil {
            XCTAssertTrue(parsedTimeZoneDesignatorWithoutMinutes == NSTimeZone(forSecondsFromGMT: (3600 * -7)), String(format: "Timezone should be -7:00, not %@", parsedTimeZoneDesignatorWithoutMinutes!))
        }
    }
    
    func testRFC3339DateTime() {
        let dateTime = "1985-04-12T23:20:50.52Z"
        
        let parsedDateTime = NSDate.parseDateString(dateTime)
        
        XCTAssertNotNil(parsedDateTime, "Date should not be nil")
        
        if parsedDateTime != nil {
            let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            
            let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second, .Nanosecond, .TimeZone], fromDate: parsedDateTime)
            
            XCTAssertTrue(components.year == 1985, String(format: "The year should be 1985, not %d", components.year))
            XCTAssertTrue(components.month == 04, String(format: "The month should be 4, not %d", components.month))
            XCTAssertTrue(components.day == 12, String(format: "The day should be 12, not %d", components.day))
            XCTAssertTrue(components.hour == 23, String(format: "The hour should be 23, not %d", components.hour))
            XCTAssertTrue(components.minute == 20, String(format: "The minute should be 20, not %d", components.minute))
            XCTAssertTrue(components.second == 50, String(format: "The seconde should be 50, not %d", components.second))
            XCTAssertTrue(components.nanosecond == 519999980, String(format: "The nano second should be 519999980, not %d", components.nanosecond))
            XCTAssertTrue(components.timeZone! == NSTimeZone(forSecondsFromGMT: 0), String(format: "The timezone should be GMT, not %@", components.timeZone!))
        }
    }
}
