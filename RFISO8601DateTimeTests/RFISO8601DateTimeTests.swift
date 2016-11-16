
import XCTest

import RFISO8601DateTime

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
    
    XCTAssertNil(Date.parseDateString(invalidDate))
  }
  
  func testCalendarMonth() {
    let calendarMonth = "2016-01"

    if let parsedDate = Date.parseDateString(calendarMonth) {
      let calendar = Calendar.current
      let components = (calendar as NSCalendar).components([.month , .year], from: parsedDate)
      
      XCTAssertTrue(components.year == 2016, String(format: "The year should be 2016, not %d", components.year!))
      XCTAssertTrue(components.month == 1, String(format: "The month should be 1, not %d", components.month!))
    }
  }
  
  func testCalendarDate() {
    let calendarMonth = "2016-01-21"

    if let parsedDate = Date.parseDateString(calendarMonth) {
      let calendar = Calendar.current
      let components = (calendar as NSCalendar).components([.day , .month , .year], from: parsedDate)

        XCTAssertTrue(components.year == 2016, String(format: "The year should be 2016, not %d", components.year!
        ))
        XCTAssertTrue(components.month == 1, String(format: "The month should be 1, not %d", components.month!))
        XCTAssertTrue(components.day == 21, String(format: "The day should be 21, not %d", components.day!))
    }
  }
  
  func testOrdinalDate() {
    let ordinalDate = "2016-021"

    if let parsedDate = Date.parseDateString(ordinalDate) {
      let calendar = Calendar.current
      let components = (calendar as NSCalendar).components([.year], from: parsedDate)
      let day = (calendar as NSCalendar).ordinality(of: .day, in: .year, for: parsedDate)
      
      XCTAssertTrue(components.year == 2016, String(format: "The year should be 2016, not %d", components.year!))
      XCTAssertTrue(day == 21, String(format: "The day should be 21, not %d", day))
    }
  }
  
  func testWeekDate() {
    let weekDate = "2016-W03-6"

    if let parsedDate = Date.parseDateString(weekDate) {
      let calendar = Calendar.current
      let components = (calendar as NSCalendar).components([.weekOfYear, .weekday, .year], from: parsedDate)
      
      XCTAssertTrue(components.year == 2016, String(format: "The year should be 2016, not %d", components.year!))
      XCTAssertTrue(components.weekOfYear == 3, String(format: "The week of the year should be 3, not %d", components.weekOfYear!))
      XCTAssertTrue(components.weekday == 6, String(format: "The day of the week should be 6, not %d", components.weekday!))
    }
  }
  
  func testWeekOfTheYear() {
    let weekOfTheYear = "2016-W03"

    if let parsedDate = Date.parseDateString(weekOfTheYear) {
      let calendar = Calendar.current
      let components = (calendar as NSCalendar).components([.weekOfYear , .year], from: parsedDate)
      
      XCTAssertTrue(components.year == 2016, String(format: "The year should be 2016, not %d", components.year!))
      XCTAssertTrue(components.weekOfYear == 3, String(format: "The week of the year should be 3, not %d", components.weekOfYear!))
    }
  }
  
  func testTimeWithFractionalSecondsAndTimezone() {
    let time = "01:45:36.123+07:00"
    
    if let parsedDate = Date.parseDateString(time) {
      
      if let timeZone = TimeZone.timeZoneWithString(time) {
        
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        let components = (calendar as NSCalendar).components([.hour, .minute, .second, .nanosecond, .timeZone], from: parsedDate)

        XCTAssertTrue(components.hour == 1, String(format: "The hour should be 1, not %d", components.hour!))
        XCTAssertTrue(components.minute == 45, String(format: "The minute should be 45, not %d", components.minute!))
        XCTAssertTrue(components.second == 36, String(format: "The seconde should be 36, not %d", components.second!))
        XCTAssertTrue(components.nanosecond == 123001098, String(format: "the nanosecond should be 123001098, not %d", components.nanosecond!))
        XCTAssertTrue((components as NSDateComponents).timeZone! == TimeZone(secondsFromGMT: 3600*7), String(format: "Timezone should be 'GMT+7:00', not %@", (components as NSDateComponents).timeZone! as CVarArg))
      }
    }
  }
  
  func testTimeWithFractionalSeconds() {
    let time = "01:45:36.123"
    
    let parsedDate = Date.parseDateString(time)
    
    XCTAssertNotNil(parsedDate, "Date should not be nil")
    
    if parsedDate != nil {
      var calendar = Calendar.current
      calendar.timeZone = TimeZone(secondsFromGMT: 0)!
      
      let components = (calendar as NSCalendar).components([.hour, .minute, .second, .nanosecond], from: parsedDate!)
      
      XCTAssertTrue(components.hour == 1, String(format: "The hour should be 1, not %d", components.hour!

      ))
      XCTAssertTrue(components.minute == 45, String(format: "The minute should be 45, not %d", components.minute!))
      XCTAssertTrue(components.second == 36, String(format: "The seconde should be 36, not %d", components.second!))
      XCTAssertTrue(components.nanosecond!/100000 == 1230, String(format: "the nanosecond should be 1230, not %d", components.nanosecond!/100000))
    }
  }
  
  func testHoursMinutesAndSeconds() {
    let time = "10:10:13"
    
    let parsedDate = Date.parseDateString(time)
    
    XCTAssertNotNil(parsedDate, "Date should not be nil")
    
    if parsedDate != nil {
      var calendar = Calendar.current
      calendar.timeZone = TimeZone(secondsFromGMT: 0)!
      
      let components = (calendar as NSCalendar).components([.hour, .minute, .second], from: parsedDate!)
      
      XCTAssertTrue(components.hour == 10, String(format: "The hour should be 10, not %d", components.hour!))
      XCTAssertTrue(components.minute == 10, String(format: "The minute should be 10, not %d", components.minute!))
      XCTAssertTrue(components.second == 13, String(format: "The seconde should be 13, not %d", components.second!))
    }
  }
  
  func testHoursMinutes() {
    let time = "17:58"

    if let parsedDate = Date.parseDateString(time) {
      var calendar = Calendar.current
      calendar.timeZone = TimeZone(secondsFromGMT: 0)!
      
      let components = (calendar as NSCalendar).components([.hour, .minute], from: parsedDate)
      
      XCTAssertTrue(components.hour == 17, String(format: "The hour should be 17, not %d", components.hour!))
      XCTAssertTrue(components.minute == 58, String(format: "The minute should be 58, not %d", components.minute!))
    }
  }
  
  func testTimeZoneDesignator() {
    //        Z, +01 or +01:00
    let timeZoneDesignatorZ = "Z"

    if let parsedTimeZoneDesignatorZ = TimeZone.timeZoneWithString(timeZoneDesignatorZ) {
      XCTAssertTrue(parsedTimeZoneDesignatorZ == TimeZone(secondsFromGMT: 0), String(format: "Timezone should be Z, not %@", parsedTimeZoneDesignatorZ as CVarArg))
    }
    
    let timeZonePossitiveWithMinutes = "+05:30" // India

    if let parsedTimeZoneDesignatorWithMinutes = TimeZone.timeZoneWithString(timeZonePossitiveWithMinutes) {
      XCTAssertTrue(parsedTimeZoneDesignatorWithMinutes == TimeZone(secondsFromGMT: ((3600 * 5) + (30 * 60))), String(format: "Timezone should be +5:30, not %@", parsedTimeZoneDesignatorWithMinutes as CVarArg))
    }
    
    let timeZoneNegativeWithoutMinutes = "-07" // India

    if let parsedTimeZoneDesignatorWithoutMinutes = TimeZone.timeZoneWithString(timeZoneNegativeWithoutMinutes) {
      XCTAssertTrue(parsedTimeZoneDesignatorWithoutMinutes == TimeZone(secondsFromGMT: (3600 * -7)), String(format: "Timezone should be -7:00, not %@", parsedTimeZoneDesignatorWithoutMinutes as CVarArg))
    }
  }

  func testDateTime() {
    let dateTime = "2016-10-18 11:58:00"

    if let parsedDateTime = Date.parseDateString(dateTime) {
      var calendar = Calendar.current
      calendar.timeZone = TimeZone(secondsFromGMT: 0)!

      let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second, .nanosecond, .timeZone], from: parsedDateTime)

      XCTAssertTrue(components.year == 2016, String(format: "The year should be 1985, not %d", components.year!))
      XCTAssertTrue(components.month == 10, String(format: "The month should be 4, not %d", components.month!))
      XCTAssertTrue(components.day == 18, String(format: "The day should be 12, not %d", components.day!))
      XCTAssertTrue(components.hour == 11, String(format: "The hour should be 23, not %d", components.hour!))
      XCTAssertTrue(components.minute == 58, String(format: "The minute should be 20, not %d", components.minute!))
      XCTAssertTrue(components.second == 00, String(format: "The seconde should be 50, not %d", components.second!))
    }
  }

  
  func testRFC3339DateTime() {
    let dateTime = "1985-04-12T23:20:50.52Z"

    if let parsedDateTime = Date.parseDateString(dateTime) {
      var calendar = Calendar.current
      calendar.timeZone = TimeZone(secondsFromGMT: 0)!
      
      let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second, .nanosecond, .timeZone], from: parsedDateTime)
      
      XCTAssertTrue(components.year == 1985, String(format: "The year should be 1985, not %d", components.year!))
      XCTAssertTrue(components.month == 04, String(format: "The month should be 4, not %d", components.month!))
      XCTAssertTrue(components.day == 12, String(format: "The day should be 12, not %d", components.day!))
      XCTAssertTrue(components.hour == 23, String(format: "The hour should be 23, not %d", components.hour!))
      XCTAssertTrue(components.minute == 20, String(format: "The minute should be 20, not %d", components.minute!))
      XCTAssertTrue(components.second == 50, String(format: "The seconde should be 50, not %d", components.second!))
      XCTAssertTrue(components.nanosecond == 519999980, String(format: "The nano second should be 519999980, not %d", components.nanosecond!))
      XCTAssertTrue((components as NSDateComponents).timeZone! == TimeZone(secondsFromGMT: 0), String(format: "The timezone should be GMT, not %@", (components as NSDateComponents).timeZone! as CVarArg))
    }
  }
  
  func testRFC2282DateTime() {
    let dateTime = "Fri, 21 Nov 1997 09:55:06 -0600"

    if let parsedDateTime = Date.parseDateString(dateTime) {

      if let timeZone = TimeZone.timeZoneWithString(dateTime) {
        var calendar = Calendar.current
        calendar.timeZone = timeZone

        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second, .timeZone], from: parsedDateTime)

        XCTAssertTrue(components.year == 1997, String(format: "The year should be 1997, not %d", components.year!))
        XCTAssertTrue(components.month == 11, String(format: "The month should be 11, not %d", components.month!))
        XCTAssertTrue(components.day == 21, String(format: "The day should be 21, not %d", components.day!))
        XCTAssertTrue(components.hour == 9, String(format: "The hour should be 9, not %d", components.hour!))
        XCTAssertTrue(components.minute == 55, String(format: "The minute should be 55, not %d", components.minute!))
        XCTAssertTrue(components.second == 06, String(format: "The seconde should be 06, not %d", components.second!))
        XCTAssertTrue((components as NSDateComponents).timeZone! == TimeZone(secondsFromGMT: (3600 * -6)), String(format: "The timezone should -06.00, not %@", (components as NSDateComponents).timeZone! as CVarArg))
      }
    }
  }
}
