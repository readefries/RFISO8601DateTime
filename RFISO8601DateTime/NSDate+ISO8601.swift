import Foundation

public extension Date {
  
  static func parseDateString(_ dateTimeString: String) -> Date? {

    var date: Date? = nil
    var time: Date? = nil
    var timeZone: TimeZone? = nil
    
    // Date and time

    // Date and time, with fractional seconds and time zone
    if let _ = dateTimeString.range(of: ISO8601Constants.DateTimeWithFractionalSecondsAndTimeZoneRegexp, options: .regularExpression) {
      if let dateRange = dateTimeString.range(of: ISO8601Constants.DateWithTimeZoneRegexp, options: .regularExpression) {
        date = dateWithString("\(dateTimeString[dateRange])")
      }

      if let timeRange = dateTimeString.range(of: ISO8601Constants.TimeWithFractionalSecondsRegexp, options: .regularExpression) {
        time = timeWithString("\(dateTimeString[timeRange])")
      }

      if let timezoneRange = dateTimeString.range(of: ISO8601Constants.TimeZoneDesignatorRegexp, options: .regularExpression) {
        timeZone = TimeZone.timeZoneWithString("\(dateTimeString[timezoneRange])")
      }

      return combineDateTimeTimezone(date, time: time, timezone: timeZone)
    }
    
    // Calendar date with hours, minutes, and seconds (e.g., 2008-08-30 17:21:59 or 20080830 172159).
    if let _ = dateTimeString.range(of: ISO8601Constants.CalenderDateHoursMinutesSecondsRegexp, options: .regularExpression) {
      if let dateRange = dateTimeString.range(of: ISO8601Constants.CalendarDateRegexp, options: .regularExpression) {
        date = dateWithString("\(dateTimeString[dateRange])")
      }
      
      if let timeRange = dateTimeString.range(of: ISO8601Constants.HoursMinutesSecondsRegexp, options: .regularExpression) {
        time = timeWithString("\(dateTimeString[timeRange])")
      }

      guard let date = date, let time = time else { return nil }

      return combineDateTime(date, time: time)
    }

    // RFC2822 Date
    if let _ = dateTimeString.range(of: ISO8601Constants.DateTimeRFC2822Regexp, options: .regularExpression) {
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.DateTimeRFC2822Format
      
      return ISO8601Constants.dateFormatter.date(from: dateTimeString)
    }
    
    if let range = dateTimeString.range(of: ISO8601Constants.WeekDateRegexp, options: .regularExpression) {
      return dateWeekWithSTring("\(dateTimeString[range])")
    }
      // Ordinal date e.g. 2016-021
    else  if let _ = dateTimeString.range(of: ISO8601Constants.OrdinalDateRegexp, options: .regularExpression) {
      let dateTimeStringWithoutDashes = dateTimeString.replacingOccurrences(of: "-", with: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.OrdinalDateFormat
      
      return ISO8601Constants.dateFormatter.date(from: dateTimeStringWithoutDashes)
    }
    
    if let dateRange = dateTimeString.range(of: ISO8601Constants.DateWithTimeZoneRegexp, options: .regularExpression) {
      date = dateWithString("\(dateTimeString[dateRange])")
    }
    
    if let timeRange = dateTimeString.range(of: ISO8601Constants.TimeWithFractionalSecondsRegexp, options: .regularExpression) {
      time = timeWithString("\(dateTimeString[timeRange])")
    }
    
    if let timezoneRange = dateTimeString.range(of: ISO8601Constants.TimeZoneDesignatorRegexp, options: .regularExpression) {
      timeZone = TimeZone.timeZoneWithString("\(dateTimeString[timezoneRange])")
    }
    
    // Only try to parse week, if now date and time has been found
    if date == nil && time == nil, let timeZone = timeZone {
      var calendar = Calendar.current
      calendar.timeZone = timeZone

      let timeComponents = DateComponents()
      (timeComponents as NSDateComponents).timeZone = timeZone
      
      return calendar.date(from: timeComponents)
    }
    else if let date = date, time == nil {
      if let timeZone = timeZone {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        
        let dateComponents = (calendar as NSCalendar).components([.year, .month, .day], from: date)
        (dateComponents as NSDateComponents).timeZone = timeZone
        
        return calendar.date(from: dateComponents)
      }
      else {
        return date
      }
    }
    else if let time = time, date == nil {
      if let timeZone = timeZone {
        return combineDateTimeTimezone(date, time: time, timezone: timeZone)
      }
      else {
        return time
      }
    }
    
    return nil
  }
  
  fileprivate static func combineDateTime(_ date: Date, time: Date) -> Date {
    return combineDateTimeTimezone(date, time: time, timezone: nil)
  }
  
  fileprivate static func combineDateTimeTimezone(_ date: Date?, time: Date?, timezone: TimeZone?) -> Date {
    
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!

    var mergedComponents = DateComponents()

    if let date = date {
      let dateComponents = (calendar as NSCalendar).components([.year, .month, .day], from: date)

      mergedComponents.year = dateComponents.year
      mergedComponents.month = dateComponents.month
      mergedComponents.day = dateComponents.day
    }

    if let time = time {
      let timeComponents = (calendar as NSCalendar).components([.hour, .minute, .second, .nanosecond], from: time)

      mergedComponents.hour = timeComponents.hour
      mergedComponents.minute = timeComponents.minute
      mergedComponents.second = timeComponents.second
      mergedComponents.nanosecond = timeComponents.nanosecond

    }

    if let timezone = timezone {
      mergedComponents.timeZone = timezone
    }

    return calendar.date(from: mergedComponents)!
  }

  fileprivate static func dateWeekWithSTring(_ dateWeekString: String) -> Date? {

    // Week of the year e.g. 2016-W03
    if let _ = dateWeekString.range(of: ISO8601Constants.WeekOfTheYearRegexp, options: .regularExpression) {
      let dateWeekStringWithoutDashes = dateWeekString.replacingOccurrences(of: "-", with: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.WeekOfTheYearFormat
      
      return ISO8601Constants.dateFormatter.date(from: dateWeekStringWithoutDashes)
    }
    
    // Week date e.g. 2016-W03-6
    if let _ = dateWeekString.range(of: ISO8601Constants.WeekDateRegexp, options: .regularExpression) {
      let dateWeekStringWithoutDashes = dateWeekString.replacingOccurrences(of: "-", with: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.WeekDateFormat
      
      return ISO8601Constants.dateFormatter.date(from: dateWeekStringWithoutDashes)
    }
    
    return nil
  }
  
  fileprivate static func dateWithString(_ dateString: String) -> Date? {
    
    // Calender month e.g. 2016-01
    if let _ = dateString.range(of: ISO8601Constants.CalendarMonthRegexp, options: .regularExpression) {
      let dateStringWithoutDashes = dateString.replacingOccurrences(of: "-", with: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.CalendarMonthFormat
      
      return ISO8601Constants.dateFormatter.date(from: dateStringWithoutDashes)
    }
    
    // Calender date e.g. 2016-01-21
    if let _ = dateString.range(of: ISO8601Constants.CalendarDateRegexp, options: .regularExpression) {
      let dateStringWithoutDashes = dateString.replacingOccurrences(of: "-", with: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.CalendarDateFormat
      
      return ISO8601Constants.dateFormatter.date(from: dateStringWithoutDashes)
    }
    
    return nil
  }
  
  fileprivate static func timeWithString(_ timeString: String) -> Date? {

    // Hours and minutes e.g. 10:10:34
    if let _ = timeString.range(of: ISO8601Constants.HoursMinutesSecondsRegexp, options: .regularExpression) {
      let timeStringWithoutDashes = timeString.replacingOccurrences(of: ":", with: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.HoursMinutesSecondsFormat

      return ISO8601Constants.dateFormatter.date(from: timeStringWithoutDashes)
    }

    // Hours and minutes e.g. 10:10
    if let _ = timeString.range(of: ISO8601Constants.HoursMinutesRegexp, options: .regularExpression) {
      let timeStringWithoutDashes = timeString.replacingOccurrences(of: ":", with: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.HoursMinutesFormat
      
      return ISO8601Constants.dateFormatter.date(from: timeStringWithoutDashes)
    }

    // Time, with fractional seconds (e.g. 01:45:36.123).
    if let _ = timeString.range(of: ISO8601Constants.TimeWithFractionalSecondsRegexp, options: .regularExpression) {
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.TimeWithFractionalSecondsFormat
      
      return ISO8601Constants.dateFormatter.date(from: timeString)
    }
    
    // Time, with fractional seconds and time zone (e.g. 01:45:36.123+07:00).
    if let _ = timeString.range(of: ISO8601Constants.TimeWithFractionalSecondsAndTimeZoneRegexp, options: .regularExpression) {
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.TimeWithFractionalSecondsAndTimeZoneFormat
      
      return ISO8601Constants.dateFormatter.date(from: timeString)
    }
    
    return nil
  }
}
