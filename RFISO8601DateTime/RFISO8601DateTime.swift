//
//  RFISO8601DateTime.swift
//  RFISO8601DateTime
//
//  Created by Hindrik Bruinsma on 21/01/16.
//  Copyright © 2016 xs4some. All rights reserved.
//

import Foundation

struct ISO8601 {
  
  static let CalendarMonthRegexp = "^([0-9]{4})-(1[0-2]|0[1-9])$"
  static let CalendarMonthFormat = "yyyyMM"
  
  static let CalendarDateRegexp = "([0-9]{4})-?(1[0-2]|0[1-9])-?(3[01]|0[1-9]|[12][0-9])"
  static let CalendarDateFormat = "yyyyMMdd"
  
  static let OrdinalDateRegexp = "([0-9]{4})-?(36[0-6]|3[0-5][0-9]|[12][0-9]{2}|0[1-9][0-9]|00[1-9])"
  static let OrdinalDateFormat = "yyyyddd"
  
  static let WeekOfTheYearRegexp = "^([0-9]{4})-?W(5[0-3]|[1-4][0-9]|0[1-9])$"
  static let WeekOfTheYearFormat = "yyyy'W'ww"
  
  static let WeekDateRegexp = "([0-9]{4})-?W(5[0-3]|[1-4][0-9]|0[1-9])?-?([1-7])?"
  static let WeekDateFormat = "yyyy'W'wwc"
  
  static let HoursMinutesRegexp = "^(2[0-3]|[01][0-9]):?([0-5][0-9])$"
  static let HoursMinutesFormat = "HHmm"
  
  static let HoursMinutesSecondsRegexp = "^(2[0-3]|[01][0-9]):?([0-5][0-9]):([0-5][0-9])$"
  static let HoursMinutesSecondsFormat = "HHmmss"
  
  static let TimeZoneDesignatorRegexp = "(Z|[+-](?:2[0-3]|[01][0-9])(?::?(?:[0-5][0-9]))?)$"
  static let TimeZoneDesignatorFormat = "X"
  
  static let HoursMinutesSecondsWithTimeZoneDesignatorRegexp = "(2[0-3]|[01][0-9]):?([0-5][0-9]):?([0-5][0-9])(Z|[+-](?:2[0-3]|[01][0-9])(?::?(?:[0-5][0-9]))?)"
  static let HoursMinutesSecondsWithTimeZoneDesignatorFormat = "hhmmssX"
  
  static let CalenderDateHoursMinutesSecondsRegexp = "([0-9]{4})-?(1[0-2]|0[1-9])-?(3[01]|0[1-9]|[12][0-9])●(2[0-3]|[01][0-9]):?([0-5][0-9]):?([0-5][0-9])"
  static let CalenderDateHoursMinutesSecondsFormat = "yyyyMMdd' 'hhmmss"
  
  static let DateWithTimeZoneRegexp = "(-?(?:[1-9][0-9]*)?[0-9]{4})-(1[0-2]|0[1-9])(-)?(3[01]|0[1-9]|[12][0-9])?(Z|[+-](?:2[0-3]|[01][0-9]):[0-5][0-9])?"
  static let DateWithTimeZoneFormat = "yyyyMMddx"
  
  static let TimeWithFractionalSecondsAndTimeZoneRegexp = "(2[0-3]|[01][0-9]):([0-5][0-9])(:)?([0-5][0-9])?(\\.[0-9]+)?(Z|[+-](?:2[0-3]|[01][0-9]):[0-5][0-9])?"
  static let TimeWithFractionalSecondsAndTimeZoneFormat = "HH:mm:ss'.'SSSZZZZ"
  
  static let TimeWithFractionalSecondsRegexp = "(2[0-3]|[01][0-9]):([0-5][0-9]):?([0-5][0-9])?(\\.[0-9]+)?"
  static let TimeWithFractionalSecondsFormat = "HH:mm:ss'.'SSS"
  
  static let DateTimeWithFractionalSecondsAndTimeZoneRegexp = "(-?(?:[1-9][0-9]*)?[0-9]{4})-(1[0-2]|0[1-9])-(3[01]|0[1-9]|[12][0-9])T(2[0-3]|[01][0-9]):([0-5][0-9]):([0-5][0-9])(\\.[0-9]+)?(Z|[+-](?:2[0-3]|[01][0-9]):[0-5][0-9])"
  static let DateTimeWithFractionalSecondsAndTimeZoneFormat = "yyyyMMdd'T'HHmmss'.'SSSX"
  
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