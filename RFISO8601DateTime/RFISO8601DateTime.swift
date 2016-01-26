//
//  RFISO8601DateTime.swift
//  RFISO8601DateTime
//
//  Created by Hindrik Bruinsma on 21/01/16.
//  Copyright © 2016 xs4some. All rights reserved.
//

import Foundation

struct ISO8601 {
    
    static let CalendarMonthRegexp: String = "^([0-9]{4})-(1[0-2]|0[1-9])$"
    static let CalendarMonthFormat: String = "yyyyMM"
    
    static let CalendarDateRegexp: String = "([0-9]{4})-?(1[0-2]|0[1-9])-?(3[01]|0[1-9]|[12][0-9])"
    static let CalendarDateFormat: String = "yyyyMMdd"
    
    static let OrdinalDateRegexp: String = "([0-9]{4})-?(36[0-6]|3[0-5][0-9]|[12][0-9]{2}|0[1-9][0-9]|00[1-9])"
    static let OrdinalDateFormat: String = "yyyyddd"
    
    static let WeekOfTheYearRegexp: String = "^([0-9]{4})-?W(5[0-3]|[1-4][0-9]|0[1-9])$"
    static let WeekOfTheYearFormat: String = "yyyy'W'ww"
    
    static let WeekDateRegexp: String = "([0-9]{4})-?W(5[0-3]|[1-4][0-9]|0[1-9])?-?([1-7])?"
    static let WeekDateFormat: String = "yyyy'W'wwc"
    
    static let HoursMinutesRegexp: String = "^(2[0-3]|[01][0-9]):?([0-5][0-9])$"
    static let HoursMinutesFormat: String = "HHmm"
    
    static let HoursMinutesSecondsRegexp: String = "^(2[0-3]|[01][0-9]):?([0-5][0-9]):([0-5][0-9])$"
    static let HoursMinutesSecondsFormat: String = "HHmmss"
    
    static let TimeZoneDesignatorRegexp: String = "(Z|[+-](?:2[0-3]|[01][0-9])(?::?(?:[0-5][0-9]))?)$"
    static let TimeZoneDesignatorFormat: String = "X"
    
    static let HoursMinutesSecondsWithTimeZoneDesignatorRegexp: String = "(2[0-3]|[01][0-9]):?([0-5][0-9]):?([0-5][0-9])(Z|[+-](?:2[0-3]|[01][0-9])(?::?(?:[0-5][0-9]))?)"
    static let HoursMinutesSecondsWithTimeZoneDesignatorFormat: String = "hhmmssX"
    
    static let CalenderDateHoursMinutesSecondsRegexp: String = "([0-9]{4})-?(1[0-2]|0[1-9])-?(3[01]|0[1-9]|[12][0-9])●(2[0-3]|[01][0-9]):?([0-5][0-9]):?([0-5][0-9])"
    static let CalenderDateHoursMinutesSecondsFormat: String = "yyyyMMdd' 'hhmmss"
    
    static let DateWithTimeZoneRegexp: String = "(-?(?:[1-9][0-9]*)?[0-9]{4})-(1[0-2]|0[1-9])(-)?(3[01]|0[1-9]|[12][0-9])?(Z|[+-](?:2[0-3]|[01][0-9]):[0-5][0-9])?"
    static let DateWithTimeZoneFormat: String = "yyyyMMddx"
    
    static let TimeWithFractionalSecondsAndTimeZoneRegexp: String = "(2[0-3]|[01][0-9]):([0-5][0-9])(:)?([0-5][0-9])?(\\.[0-9]+)?(Z|[+-](?:2[0-3]|[01][0-9]):[0-5][0-9])?"
    static let TimeWithFractionalSecondsAndTimeZoneFormat: String = "HH:mm:ss'.'SSSZZZZ"
    
    static let TimeWithFractionalSecondsRegexp: String = "(2[0-3]|[01][0-9]):([0-5][0-9]):?([0-5][0-9])?(\\.[0-9]+)?"
    static let TimeWithFractionalSecondsFormat: String = "HH:mm:ss'.'SSS"
    
    static let DateTimeWithFractionalSecondsAndTimeZoneRegexp: String = "(-?(?:[1-9][0-9]*)?[0-9]{4})-(1[0-2]|0[1-9])-(3[01]|0[1-9]|[12][0-9])T(2[0-3]|[01][0-9]):([0-5][0-9]):([0-5][0-9])(\\.[0-9]+)?(Z|[+-](?:2[0-3]|[01][0-9]):[0-5][0-9])"
    static let DateTimeWithFractionalSecondsAndTimeZoneFormat: String = "yyyyMMdd'T'HHmmss'.'SSSX"
    
    static var dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        return formatter
    }()
    
    static var numberFormatter: NSNumberFormatter = {
       let formatter = NSNumberFormatter()

        return formatter
    }()
}