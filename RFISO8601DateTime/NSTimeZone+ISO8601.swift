
import Foundation

public extension TimeZone {
  // Time zone designator e.g., Z, +01 or +01:00
  static func timeZoneWithString(_ dateString: String) -> TimeZone! {
    
    var timeZoneString: String!
    
    if let rangeOfTimezone = dateString.range(of: ISO8601Constants.TimeZoneDesignatorRegexp, options: .regularExpression) {
      timeZoneString = String(dateString[rangeOfTimezone.lowerBound..<rangeOfTimezone.upperBound])

      if timeZoneString == "Z" {
        return TimeZone(secondsFromGMT: 0)
      }
      
      if let _ = timeZoneString.range(of: ISO8601Constants.TimeZoneDesignatorRegexp, options: .regularExpression) {
        timeZoneString = timeZoneString.replacingOccurrences(of: ":", with: "")

        let hoursString = "\(timeZoneString[timeZoneString.index(timeZoneString.startIndex, offsetBy: 1)..<timeZoneString.index(timeZoneString.startIndex, offsetBy: 3)])"
        var minutesString: String! = nil
        
        if timeZoneString.count == 5 {
          minutesString = "\(timeZoneString[timeZoneString.index(timeZoneString.startIndex, offsetBy: 3)..<timeZoneString.index(timeZoneString.startIndex, offsetBy: 5)])"
        }
        
        let formatter = NumberFormatter()
        
        let hours = formatter.number(from: hoursString)
        let minutes = minutesString == nil ? (0) : formatter.number(from: minutesString as String)
        
        var seconds = ((hours?.intValue)! * 3600) + ((minutes?.intValue)! * 60)

        if timeZoneString.firstIndex(of: "\u{2d}") != nil {
          seconds = seconds * -1
        }
        
        return TimeZone(secondsFromGMT: seconds)
      }
    }
    
    return nil
  }
}
