//
//  NSTimeZone+ISO8601.swift
//  RFISO8601DateTime
//
//  Created by Hindrik Bruinsma on 25/01/16.
//  Copyright © 2016 xs4some. All rights reserved.
//

import Foundation

public extension NSTimeZone {
  // Time zone designator e.g., Z, +01 or +01:00
  public static func timeZoneWithString(dateString: String) -> NSTimeZone! {
    
    var timeZoneString: String!
    
    if let rangeOfTimezone = dateString.rangeOfString(ISO8601.TimeZoneDesignatorRegexp, options: .RegularExpressionSearch) {
      timeZoneString = dateString.substringWithRange(rangeOfTimezone)
      
      if timeZoneString == "Z" {
        return NSTimeZone(forSecondsFromGMT: 0)
      }
      
      if let _ = timeZoneString.rangeOfString(ISO8601.TimeZoneDesignatorRegexp, options: .RegularExpressionSearch) {
        timeZoneString = timeZoneString.stringByReplacingOccurrencesOfString(":", withString: "")
        let string = timeZoneString as NSString
        
        let hoursString = string.substringWithRange(NSRange(location: 1,length: 2))
        var minutesString: NSString! = nil
        
        if string.length == 5 {
          minutesString = string.substringWithRange(NSRange(location: 3,length: 2))
        }
        
        let formatter = NSNumberFormatter()
        
        let hours = formatter.numberFromString(hoursString)
        let minutes = minutesString == nil ? (0) : formatter.numberFromString(minutesString as String)
        
        var seconds = ((hours?.integerValue)! * 3600) + ((minutes?.integerValue)! * 60)
        
        if timeZoneString.characters.indexOf("\u{2d}") != nil {
          seconds = seconds * -1
        }
        
        return NSTimeZone(forSecondsFromGMT: seconds)
      }
    }
    
    return nil
  }
}