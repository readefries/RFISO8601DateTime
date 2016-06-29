
import Foundation

public extension NSDate {
  
  public static func parseDateString(dateTimeString: String) -> NSDate! {
    
    var date: NSDate! = nil
    var time: NSDate! = nil
    var timeZone: NSTimeZone! = nil
    
    // Date and time
    
    // Calendar date with hours, minutes, and seconds (e.g., 2008-08-30 17:21:59 or 20080830 172159).
    if let _ = dateTimeString.rangeOfString(ISO8601Constants.CalenderDateHoursMinutesSecondsRegexp, options: .RegularExpressionSearch) {
      if let dateRange = dateTimeString.rangeOfString(ISO8601Constants.CalendarDateRegexp, options: .RegularExpressionSearch) {
        date = dateWithString(dateTimeString.substringWithRange(dateRange))
      }
      
      if let timeRange = dateTimeString.rangeOfString(ISO8601Constants.HoursMinutesSecondsRegexp, options: .RegularExpressionSearch) {
        time = timeWithString(dateTimeString.substringWithRange(timeRange))
      }
      
      return combineDateTime(date, time: time)
    }
    
    // Date and time, with fractional seconds and time zone
    if let _ = dateTimeString.rangeOfString(ISO8601Constants.DateTimeWithFractionalSecondsAndTimeZoneRegexp, options: .RegularExpressionSearch) {
      if let dateRange = dateTimeString.rangeOfString(ISO8601Constants.DateWithTimeZoneRegexp, options: .RegularExpressionSearch) {
        date = dateWithString(dateTimeString.substringWithRange(dateRange))
      }
      
      if let timeRange = dateTimeString.rangeOfString(ISO8601Constants.TimeWithFractionalSecondsRegexp, options: .RegularExpressionSearch) {
        time = timeWithString(dateTimeString.substringWithRange(timeRange))
      }
      
      if let timezoneRange = dateTimeString.rangeOfString(ISO8601Constants.TimeZoneDesignatorRegexp, options: .RegularExpressionSearch) {
        timeZone = NSTimeZone.timeZoneWithString(dateTimeString.substringWithRange(timezoneRange))
      }
      
      if timeZone == NSTimeZone(forSecondsFromGMT: 0) {
        return combineDateTime(date, time: time)
      }
      
      return combineDateTimeTimezone(date, time: time, timezone: timeZone)
    }
    
    // RFC2822 Date
    if let _ = dateTimeString.rangeOfString(ISO8601Constants.DateTimeRFC2822Regexp, options: .RegularExpressionSearch) {
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.DateTimeRFC2822Format
      
      return ISO8601Constants.dateFormatter.dateFromString(dateTimeString)
    }
    
    if let range = dateTimeString.rangeOfString(ISO8601Constants.WeekDateRegexp, options: .RegularExpressionSearch) {
      return dateWeekWithSTring(dateTimeString.substringWithRange(range))
    }
      // Ordinal date e.g. 2016-021
    else  if let _ = dateTimeString.rangeOfString(ISO8601Constants.OrdinalDateRegexp, options: .RegularExpressionSearch) {
      let dateTimeStringWithoutDashes = dateTimeString.stringByReplacingOccurrencesOfString("-", withString: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.OrdinalDateFormat
      
      return ISO8601Constants.dateFormatter.dateFromString(dateTimeStringWithoutDashes)
    }
    
    if let dateRange = dateTimeString.rangeOfString(ISO8601Constants.DateWithTimeZoneRegexp, options: .RegularExpressionSearch) {
      date = dateWithString(dateTimeString.substringWithRange(dateRange))
    }
    
    if let range = dateTimeString.rangeOfString(ISO8601Constants.TimeWithFractionalSecondsRegexp, options: .RegularExpressionSearch) {
      time = timeWithString(dateTimeString.substringWithRange(range))
    }
    
    if let timezoneRange = dateTimeString.rangeOfString(ISO8601Constants.TimeZoneDesignatorRegexp, options: .RegularExpressionSearch) {
      timeZone = NSTimeZone.timeZoneWithString(dateTimeString.substringWithRange(timezoneRange))
    }
    
    // Only try to parse week, if now date and time has been found
    if date == nil && time == nil && timeZone != nil {
      let calendar = NSCalendar.currentCalendar()
      calendar.timeZone = timeZone
      
      let timeComponents = NSDateComponents()
      timeComponents.timeZone = timeZone
      
      return calendar.dateFromComponents(timeComponents)
    }
    else if date != nil && time == nil {
      if timeZone != nil {
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        let dateComponents = calendar.components([.Year, .Month, .Day], fromDate: date)
        dateComponents.timeZone = timeZone
        
        return calendar.dateFromComponents(dateComponents)
      }
      else {
        return date
      }
    }
    else if time != nil && date == nil {
      if timeZone != nil {
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        let timeComponents = calendar.components([.Hour, .Minute, .Second, .Nanosecond], fromDate: time)
        timeComponents.timeZone = timeZone
        
        return calendar.dateFromComponents(timeComponents)
      }
      else {
        return time
      }
    }
    
    return nil
  }
  
  private static func combineDateTime(date: NSDate, time: NSDate) -> NSDate {
    return combineDateTimeTimezone(date, time: time, timezone: nil);
  }
  
  private static func combineDateTimeTimezone(date: NSDate, time: NSDate, timezone: NSTimeZone!) -> NSDate {
    
    let calendar = NSCalendar.currentCalendar()
    calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0)
    
    let dateComponents = calendar.components([.Year, .Month, .Day], fromDate: date)
    let timeComponents = calendar.components([.Hour, .Minute, .Second, .Nanosecond], fromDate: time)
    
    let mergedComponents = NSDateComponents()
    mergedComponents.year = dateComponents.year
    mergedComponents.month = dateComponents.month
    mergedComponents.day = dateComponents.day
    
    mergedComponents.hour = timeComponents.hour
    mergedComponents.minute = timeComponents.minute
    mergedComponents.second = timeComponents.second
    mergedComponents.nanosecond = timeComponents.nanosecond
    
    if timezone == nil {
      mergedComponents.timeZone = NSTimeZone(forSecondsFromGMT: 0)
    }
    
    return calendar.dateFromComponents(mergedComponents)!
  }

  private static func dateWeekWithSTring(dateWeekString: String) -> NSDate! {
    
    // Week of the year e.g. 2016-W03
    if let _ = dateWeekString.rangeOfString(ISO8601Constants.WeekOfTheYearRegexp, options: .RegularExpressionSearch) {
      let dateWeekStringWithoutDashes = dateWeekString.stringByReplacingOccurrencesOfString("-", withString: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.WeekOfTheYearFormat
      
      return ISO8601Constants.dateFormatter.dateFromString(dateWeekStringWithoutDashes)
    }
    
    // Week date e.g. 2016-W03-6
    if let _ = dateWeekString.rangeOfString(ISO8601Constants.WeekDateRegexp, options: .RegularExpressionSearch) {
      let dateWeekStringWithoutDashes = dateWeekString.stringByReplacingOccurrencesOfString("-", withString: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.WeekDateFormat
      
      return ISO8601Constants.dateFormatter.dateFromString(dateWeekStringWithoutDashes)
    }
    
    return nil
  }
  
  private static func dateWithString(dateString: String) -> NSDate! {
    
    // Calender month e.g. 2016-01
    if let _ = dateString.rangeOfString(ISO8601Constants.CalendarMonthRegexp, options: .RegularExpressionSearch) {
      let dateStringWithoutDashes = dateString.stringByReplacingOccurrencesOfString("-", withString: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.CalendarMonthFormat
      
      return ISO8601Constants.dateFormatter.dateFromString(dateStringWithoutDashes)!
    }
    
    // Calender date e.g. 2016-01-21
    if let _ = dateString.rangeOfString(ISO8601Constants.CalendarDateRegexp, options: .RegularExpressionSearch) {
      let dateStringWithoutDashes = dateString.stringByReplacingOccurrencesOfString("-", withString: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.CalendarDateFormat
      
      return ISO8601Constants.dateFormatter.dateFromString(dateStringWithoutDashes)!
    }
    
    return nil
  }
  
  private static func timeWithString(timeString: String) -> NSDate! {
    
    // Hours and minutes e.g. 10:10
    if let _ = timeString.rangeOfString(ISO8601Constants.HoursMinutesRegexp, options: .RegularExpressionSearch) {
      let timeStringWithoutDashes = timeString.stringByReplacingOccurrencesOfString(":", withString: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.HoursMinutesFormat
      
      return ISO8601Constants.dateFormatter.dateFromString(timeStringWithoutDashes)!
    }
    
    // Hours and minutes e.g. 10:10:34
    if let _ = timeString.rangeOfString(ISO8601Constants.HoursMinutesSecondsRegexp, options: .RegularExpressionSearch) {
      let timeStringWithoutDashes = timeString.stringByReplacingOccurrencesOfString(":", withString: "")
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.HoursMinutesSecondsFormat
      
      return ISO8601Constants.dateFormatter.dateFromString(timeStringWithoutDashes)!
    }
    
    // Time, with fractional seconds (e.g. 01:45:36.123).
    if let _ = timeString.rangeOfString(ISO8601Constants.TimeWithFractionalSecondsRegexp, options: .RegularExpressionSearch) {
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.TimeWithFractionalSecondsFormat
      
      return ISO8601Constants.dateFormatter.dateFromString(timeString)!
    }
    
    // Time, with fractional seconds and time zone (e.g. 01:45:36.123+07:00).
    if let _ = timeString.rangeOfString(ISO8601Constants.TimeWithFractionalSecondsAndTimeZoneRegexp, options: .RegularExpressionSearch) {
      ISO8601Constants.dateFormatter.dateFormat = ISO8601Constants.TimeWithFractionalSecondsAndTimeZoneFormat
      
      return ISO8601Constants.dateFormatter.dateFromString(timeString)!
    }
    
    return nil
  }
}
