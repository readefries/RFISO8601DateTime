
import Foundation

struct ISO8601Constants {
  
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
  
  static let HoursMinutesRegexp = "(2[0-3]|[01][0-9]):?([0-5][0-9])$"
  static let HoursMinutesFormat = "HHmm"
  
  static let HoursMinutesSecondsRegexp = "(2[0-3]|[01][0-9]):?([0-5][0-9]):([0-5][0-9])$"
  static let HoursMinutesSecondsFormat = "HHmmss"
  
  static let TimeZoneDesignatorRegexp = "(Z|[+-](?:2[0-3]|[01][0-9])(?::?(?:[0-5][0-9]))?)$"
  static let TimeZoneDesignatorFormat = "X"
  
  static let HoursMinutesSecondsWithTimeZoneDesignatorRegexp = "(2[0-3]|[01][0-9]):?([0-5][0-9]):?([0-5][0-9])(Z|[+-](?:2[0-3]|[01][0-9])(?::?(?:[0-5][0-9]))?)"
  static let HoursMinutesSecondsWithTimeZoneDesignatorFormat = "hhmmssX"
  
  static let CalenderDateHoursMinutesSecondsRegexp = "([0-9]{4})-?(1[0-2]|0[1-9])-?(3[01]|0[1-9]|[12][0-9])( |T)(2[0-3]|[01][0-9]):?([0-5][0-9]):?([0-5][0-9])"
  static let CalenderDateHoursMinutesSecondsFormat = "yyyyMMdd' 'hhmmss"
  
  static let DateWithTimeZoneRegexp = "(-?(?:[1-9][0-9]*)?[0-9]{4})-(1[0-2]|0[1-9])(-)?(3[01]|0[1-9]|[12][0-9])?(Z|[+-](?:2[0-3]|[01][0-9]):[0-5][0-9])?"
  static let DateWithTimeZoneFormat = "yyyyMMddx"
  
  static let TimeWithFractionalSecondsAndTimeZoneRegexp = "(2[0-3]|[01][0-9]):([0-5][0-9])(:)?([0-5][0-9])?(\\.[0-9]+)?(Z|[+-](?:2[0-3]|[01][0-9]):[0-5][0-9])?"
  static let TimeWithFractionalSecondsAndTimeZoneFormat = "HH:mm:ss'.'SSSZZZZ"
  
  static let TimeWithFractionalSecondsRegexp = "(2[0-3]|[01][0-9]):([0-5][0-9]):?([0-5][0-9])?(\\.[0-9]+)?"
  static let TimeWithFractionalSecondsFormat = "HH:mm:ss'.'SSS"
  
  static let DateTimeWithFractionalSecondsAndTimeZoneRegexp = "(-?(?:[1-9][0-9]*)?[0-9]{4})-(1[0-2]|0[1-9])-(3[01]|0[1-9]|[12][0-9])( |T)(2[0-3]|[01][0-9]):([0-5][0-9]):([0-5][0-9])(\\.[0-9]+)?(Z|[+-](?:2[0-3]|[01][0-9]):[0-5][0-9])"
  static let DateTimeWithFractionalSecondsAndTimeZoneFormat = "yyyyMMdd'T'HHmmss'.'SSSX"
  
  static let DateTimeRFC2822Regexp = "^(?:(Sun|Mon|Tue|Wed|Thu|Fri|Sat),\\s+)?(0[1-9]|[1-2]?[0-9]|3[01])\\s+(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\\s+(19[0-9]{2}|[2-9][0-9]{3})\\s+(2[0-3]|[0-1][0-9]):([0-5][0-9])(?::(60|[0-5][0-9]))?\\s+([-\\+][0-9]{2}[0-5][0-9]|(?:UT|GMT|(?:E|C|M|P)(?:ST|DT)|[A-IK-Z]))(\\s+|\\(([^\\(\\)]+|\\\\\\(|\\\\\\))*\\))*$"
  static let DateTimeRFC2822Format = "EEE', 'dd' 'MMM' 'yyyy' 'HH':'mm':'ss' 'Z"
  
  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    return formatter
  }()
  
  static var numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    
    return formatter
  }()
}
