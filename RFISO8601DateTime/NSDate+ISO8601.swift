//
//  NSDate+ISO8601.swift
//  RFISO8601DateTime
//
//  Created by Hindrik Bruinsma on 21/01/16.
//  Copyright © 2016 xs4some. All rights reserved.
//

import Foundation

public extension NSDate {

    public static func parseDateString(var dateTimeString: String) -> NSDate! {
        
        var date: NSDate! = nil
        var time: NSDate! = nil
        var timeZone: NSTimeZone! = nil
        
        // Date and time
        
        // Calendar date with hours, minutes, and seconds (e.g., 2008-08-30 17:21:59 or 20080830 172159).
        if let _ = dateTimeString.rangeOfString(ISO8601.CalenderDateHoursMinutesSecondsRegexp, options: .RegularExpressionSearch) {
            if let dateRange = dateTimeString.rangeOfString(ISO8601.CalendarDateRegexp, options: .RegularExpressionSearch) {
                date = dateWithString(dateTimeString.substringWithRange(dateRange))
            }
            
            if let timeRange = dateTimeString.rangeOfString(ISO8601.HoursMinutesSecondsRegexp, options: .RegularExpressionSearch) {
                time = timeWithString(dateTimeString.substringWithRange(timeRange))
            }
            
            return combineDateTime(date, time: time)
        }
        
        // Date and time, with fractional seconds and time zone
        if let _ = dateTimeString.rangeOfString(ISO8601.DateTimeWithFractionalSecondsAndTimeZoneRegexp, options: .RegularExpressionSearch) {
            if let dateRange = dateTimeString.rangeOfString(ISO8601.DateWithTimeZoneRegexp, options: .RegularExpressionSearch) {
                date = dateWithString(dateTimeString.substringWithRange(dateRange))
            }
            
            if let timeRange = dateTimeString.rangeOfString(ISO8601.TimeWithFractionalSecondsRegexp, options: .RegularExpressionSearch) {
                time = timeWithString(dateTimeString.substringWithRange(timeRange))
            }
            
            if let timezoneRange = dateTimeString.rangeOfString(ISO8601.TimeZoneDesignatorRegexp, options: .RegularExpressionSearch) {
                timeZone = NSTimeZone.timeZoneWithString(dateTimeString.substringWithRange(timezoneRange))
            }
            
            if timeZone == NSTimeZone(forSecondsFromGMT: 0) {
                return combineDateTime(date, time: time)
            }
            
            return combineDateTimeTimezone(date, time: time, timezone: timeZone)
        }
        
        if let range = dateTimeString.rangeOfString(ISO8601.WeekDateRegexp, options: .RegularExpressionSearch) {
            return dateWeekWithSTring(dateTimeString.substringWithRange(range))
        }
            // Ordinal date e.g. 2016-021
        else  if let _ = dateTimeString.rangeOfString(ISO8601.OrdinalDateRegexp, options: .RegularExpressionSearch) {
            dateTimeString = dateTimeString.stringByReplacingOccurrencesOfString("-", withString: "")
            ISO8601.dateFormatter.dateFormat = ISO8601.OrdinalDateFormat
            
            return ISO8601.dateFormatter.dateFromString(dateTimeString)
        }
 
        if let dateRange = dateTimeString.rangeOfString(ISO8601.DateWithTimeZoneRegexp, options: .RegularExpressionSearch) {
            date = dateWithString(dateTimeString.substringWithRange(dateRange))
        }

        if let range = dateTimeString.rangeOfString(ISO8601.TimeWithFractionalSecondsRegexp, options: .RegularExpressionSearch) {
            time = timeWithString(dateTimeString.substringWithRange(range))
        }
        
        if let timezoneRange = dateTimeString.rangeOfString(ISO8601.TimeZoneDesignatorRegexp, options: .RegularExpressionSearch) {
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
    
    private static func dateWeekWithSTring(var dateWeekString: String) -> NSDate! {
        
        // Week of the year e.g. 2016-W03
        if let _ = dateWeekString.rangeOfString(ISO8601.WeekOfTheYearRegexp, options: .RegularExpressionSearch) {
            dateWeekString = dateWeekString.stringByReplacingOccurrencesOfString("-", withString: "")
            ISO8601.dateFormatter.dateFormat = ISO8601.WeekOfTheYearFormat
            
            return ISO8601.dateFormatter.dateFromString(dateWeekString)
        }

        // Week date e.g. 2016-W03-6
        if let _ = dateWeekString.rangeOfString(ISO8601.WeekDateRegexp, options: .RegularExpressionSearch) {
            dateWeekString = dateWeekString.stringByReplacingOccurrencesOfString("-", withString: "")
            ISO8601.dateFormatter.dateFormat = ISO8601.WeekDateFormat
            
            return ISO8601.dateFormatter.dateFromString(dateWeekString)
        }
       
        return nil
    }
    
    private static func dateWithString(var dateString: String) -> NSDate! {
        
        // Calender month e.g. 2016-01
        if let _ = dateString.rangeOfString(ISO8601.CalendarMonthRegexp, options: .RegularExpressionSearch) {
            dateString = dateString.stringByReplacingOccurrencesOfString("-", withString: "")
            ISO8601.dateFormatter.dateFormat = ISO8601.CalendarMonthFormat
            
            return ISO8601.dateFormatter.dateFromString(dateString)!
        }
        
        // Calender date e.g. 2016-01-21
        if let _ = dateString.rangeOfString(ISO8601.CalendarDateRegexp, options: .RegularExpressionSearch) {
            dateString = dateString.stringByReplacingOccurrencesOfString("-", withString: "")
            ISO8601.dateFormatter.dateFormat = ISO8601.CalendarDateFormat
            
            return ISO8601.dateFormatter.dateFromString(dateString)!
        }
        
        return nil
    }
    
    private static func timeWithString(var timeString: String) -> NSDate! {
        
        // Hours and minutes e.g. 10:10
        if let _ = timeString.rangeOfString(ISO8601.HoursMinutesRegexp, options: .RegularExpressionSearch) {
            timeString = timeString.stringByReplacingOccurrencesOfString(":", withString: "")
            ISO8601.dateFormatter.dateFormat = ISO8601.HoursMinutesFormat
            
            return ISO8601.dateFormatter.dateFromString(timeString)!
        }

        // Hours and minutes e.g. 10:10:34
        if let _ = timeString.rangeOfString(ISO8601.HoursMinutesSecondsRegexp, options: .RegularExpressionSearch) {
            timeString = timeString.stringByReplacingOccurrencesOfString(":", withString: "")
            ISO8601.dateFormatter.dateFormat = ISO8601.HoursMinutesSecondsFormat
            
            return ISO8601.dateFormatter.dateFromString(timeString)!
        }

        // Time, with fractional seconds (e.g. 01:45:36.123).
        if let _ = timeString.rangeOfString(ISO8601.TimeWithFractionalSecondsRegexp, options: .RegularExpressionSearch) {
            ISO8601.dateFormatter.dateFormat = ISO8601.TimeWithFractionalSecondsFormat
            
            return ISO8601.dateFormatter.dateFromString(timeString)!
        }
        
        // Time, with fractional seconds and time zone (e.g. 01:45:36.123+07:00).
        if let _ = timeString.rangeOfString(ISO8601.TimeWithFractionalSecondsAndTimeZoneRegexp, options: .RegularExpressionSearch) {
            ISO8601.dateFormatter.dateFormat = ISO8601.TimeWithFractionalSecondsAndTimeZoneFormat
            
            return ISO8601.dateFormatter.dateFromString(timeString)!
        }

        return nil
    }
    
   }