
import Foundation

public extension TimeZone {
  // Time zone designator e.g., Z, +01 or +01:00
  public static func timeZoneWithString(_ dateString: String) -> TimeZone! {
    
    var timeZoneString: String!
    
    if let rangeOfTimezone = dateString.range(of: ISO8601Constants.TimeZoneDesignatorRegexp, options: .regularExpression) {
      timeZoneString = dateString.substring(with: rangeOfTimezone)
      
      if timeZoneString == "Z" {
        return TimeZone(secondsFromGMT: 0)
      }
      
      if let _ = timeZoneString.range(of: ISO8601Constants.TimeZoneDesignatorRegexp, options: .regularExpression) {
        timeZoneString = timeZoneString.replacingOccurrences(of: ":", with: "")
        let string = timeZoneString as NSString
        
        let hoursString = string.substring(with: NSRange(location: 1,length: 2))
        var minutesString: NSString! = nil
        
        if string.length == 5 {
          minutesString = string.substring(with: NSRange(location: 3,length: 2)) as NSString!
        }
        
        let formatter = NumberFormatter()
        
        let hours = formatter.number(from: hoursString)
        let minutes = minutesString == nil ? (0) : formatter.number(from: minutesString as String)
        
        var seconds = ((hours?.intValue)! * 3600) + ((minutes?.intValue)! * 60)
        
        if timeZoneString.characters.index(of: "\u{2d}") != nil {
          seconds = seconds * -1
        }
        
        return TimeZone(secondsFromGMT: seconds)
      }
    }
    
    return nil
  }
}
