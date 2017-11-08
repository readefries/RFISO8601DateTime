# RFISO8601DateTime

[![CI Status](http://img.shields.io/travis/readefries/RFISO8601DateTime.svg?style=flat)](https://travis-ci.org/readefries/RFISO8601DateTime)
[![Version](https://img.shields.io/cocoapods/v/RFISO8601DateTime.svg?style=flat)](http://cocoapods.org/pods/RFISO8601DateTime)
[![License](https://img.shields.io/cocoapods/l/RFISO8601DateTime.svg?style=flat)](http://cocoapods.org/pods/RFISO8601DateTime)
[![Platform](https://img.shields.io/cocoapods/p/RFISO8601DateTime.svg?style=flat)](http://cocoapods.org/pods/RFISO8601DateTime)

## Usage

Using is very easy, to parse an RFC3339 date/time string, just do the following.

```
let rfc3339DateTime = "1985-04-12T23:20:50.52Z"
let parsedDateTime = NSDate.parseDateString(rfc3339DateTime)
```

## Supported date/time formats

RFISO8601DateTime currently supports the following date/time formats:
* calendar month (e.g., 2008-08).
* Calendar date, such as 2008-08-30 or 20080830.
* Ordinal date (e.g., 2008-243). 
* Week of the year (e.g., 2008-W35).
* Week date (e.g., 2008-W35-6).
* Hours and minutes (e.g., 17:21).
* Hours, minutes, and seconds (e.g., 17:21:59).
* Time zone designator (e.g., Z, +07 or +07:00).
* Hours, minutes, and seconds with time zone designator (e.g., 17:21:59+07:00). 
* Calendar date with hours, minutes, and seconds (e.g., 2008-08-30 17:21:59 or 20080830 172159).
* Date, with optional time zone (e.g., 2008-08-30 or 2008-08-30+07:00).
* Time, with optional fractional seconds and time zone (e.g., 01:45:36 or 01:45:36.123+07:00).
* Date and time, with optional fractional seconds and time zone (e.g., 2008-08-30T01:45:36 or 2008-08-30T01:45:36.123Z).
* Date and time in RFC2822 format (e.g. Fri, 21 Nov 1997 09:55:06 -0600).

## Requirements

## Installation

RFISO8601DateTime is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'RFISO8601DateTime', '~> 3.0' # Swift 4.0
```

```
pod 'RFISO8601DateTime', '~> 2.0' # Swift 3.0
```

```
pod 'RFISO8601DateTime', '~> 1.0' # Swift 2.3
```

## Author

Hindrik Bruinsma, de@readefries.nl

## License

RFISO8601DateTime is available under the MIT license. See the LICENSE file for more info.
