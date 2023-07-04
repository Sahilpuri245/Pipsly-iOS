//
//  Date+Ext.swift
//  ROUTE
//
//  Created by Sumit Tripathi on 18/04/17.
//  Copyright © 2017 KiwiTech. All rights reserved.
//

import Foundation

extension Date {
    /// Return Date Component of Current Date
    func getTodayDate() -> Date {
        let date: Date = Date()
        let cal: Calendar = Calendar(identifier: .gregorian)
        let newDate: Date = cal.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
        return newDate
    }
    /// Check if this date is less than other date
    func isLessDateThan(_ dateToCompare: Date) -> Bool {
        var isLess = false
        if self.compare(dateToCompare) == .orderedAscending {
            isLess = true
        }
        return isLess
    }

    func yearsBetweenDate(_ startDate: Date, endDate: Date) -> Int {
        let calendar: NSCalendar = {
            let calendar = NSCalendar.current
            return calendar as NSCalendar
        }()
        let components = calendar.components(.year, from: startDate, to: endDate, options: [])
        return components.year!
    }

    func getDateStringForFeedList() -> String {
        let now = Date()
        let yearDifference: Int   =  self.numberOfDifferenceUntilDateTimeWithUnit(.year, toDateTime: now)
        let monthDifference: Int  =  self.numberOfDifferenceUntilDateTimeWithUnit(.month, toDateTime: now)
        let dayDifference: Int    =  self.numberOfDifferenceUntilDateTimeWithUnit(.day, toDateTime: now)
        let hourDifference: Int   =  self.numberOfDifferenceUntilDateTimeWithUnit(.hour, toDateTime: now)
        let minuteDifference: Int =  self.numberOfDifferenceUntilDateTimeWithUnit(.minute, toDateTime: now)
        var timestamp: String?
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return formatter
        }()
        formatter.locale = Locale.current

        var strDate1: String? = ""

        if (yearDifference <= 0 && monthDifference <= 0 && dayDifference <= 0 && hourDifference <= 0 && minuteDifference < 1) {
            //"Just Now"
            timestamp = "Just Now"
        } else if (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 && hourDifference == 0 && minuteDifference == 1) {
            //"1 m"
            timestamp = String(format: "%ld minute ago", minuteDifference)
        } else if (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 && hourDifference == 0 && minuteDifference < 60) {
            //"13m"
            timestamp = String(format: "%ld minutes ago", minuteDifference)
        } else if (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 && hourDifference == 1) {
            //"1h
            timestamp = "1 hour ago"
        } else if (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 && hourDifference < 24) {
            // "12h
            timestamp = String(format: "%ld hours ago", hourDifference)
        } else {
            if (yearDifference == 0 && monthDifference == 0 && dayDifference == 1) {
                //"Yesterday"
                timestamp = String(format: "Yesterday")
            } else if (yearDifference == 0 && monthDifference == 0 && dayDifference < 7) {
                //"Tuesday"
                formatter.dateFormat = "EEEE"
                strDate1 = formatter.string(from: self)
                timestamp = String(format: "%@", strDate1!)

            } else {
                formatter.dateFormat = "MM/dd/yyyy"
                strDate1 = formatter.string(from: self)
                timestamp = String(format: "%@", strDate1!)
            }
        }
        return timestamp!
    }

    func getDateStringForChatMessageHistoryList() -> String {
        let now = Date()
        let yearDifference: Int   =  self.numberOfDifferenceUntilDateTimeWithUnit(.year, toDateTime: now)
        let monthDifference: Int  =  self.numberOfDifferenceUntilDateTimeWithUnit(.month, toDateTime: now)
        let dayDifference: Int    =  self.numberOfDifferenceUntilDateTimeWithUnit(.day, toDateTime: now)
        let hourDifference: Int   =  self.numberOfDifferenceUntilDateTimeWithUnit(.hour, toDateTime: now)
        let minuteDifference: Int =  self.numberOfDifferenceUntilDateTimeWithUnit(.minute, toDateTime: now)
        var timestamp: String?
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return formatter
        }()
        formatter.locale = Locale.current
        var strDate1: String? = ""
        if (minuteDifference <= 0) {
             formatter.dateFormat = "h:mm a"
            strDate1 = formatter.string(from: self)
            timestamp = String(format: "%@", strDate1!)
        } else if (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 && hourDifference == 0 && minuteDifference <= 0) {
            formatter.dateFormat = "h:mm a"
            strDate1 = formatter.string(from: self)
            timestamp = String(format: "%@", strDate1!)
        } else if (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 && hourDifference == 0 && minuteDifference < 60) {
            formatter.dateFormat = "h:mm a"
            strDate1 = formatter.string(from: self)
            timestamp = String(format: "%@", strDate1!)
        } else if (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 && hourDifference == 1) {
            formatter.dateFormat = "h:mm a"
            strDate1 = formatter.string(from: self)
            timestamp = String(format: "%@", strDate1!)
        } else if (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 && hourDifference < 24) {
             formatter.dateFormat = "h:mm a"
            strDate1 = formatter.string(from: self)
            timestamp = String(format: "%@", strDate1!)
        } else {
            if (yearDifference == 0 && monthDifference == 0 && dayDifference == 1) {
                //"Yesterday"
                timestamp = String(format: "Yesterday")
            } else if (yearDifference == 0 && monthDifference == 0 && dayDifference < 7) {
                //"Tuesday"
                formatter.dateFormat = "EEEE"
                strDate1 = formatter.string(from: self)
                timestamp = String(format: "%@", strDate1!)

            } else {
                //"24/03/10"
                formatter.dateFormat = "MM/dd/yy"
                strDate1 = formatter.string(from: self)
                timestamp = String(format: "%@", strDate1!)
            }
        }
        return timestamp!
    }

    func is24HourTimeForDate() -> Bool {
        let locale = NSLocale.current
        let dateFormat = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale)!
        if dateFormat.range(of: "a") != nil {
            return false
        } else {
            return true
        }
    }

    func getSectionDateString() -> String {
        var string = ""
        if Calendar.autoupdatingCurrent.isDateInToday(self) {
            string = "Today"
        } else if Calendar.autoupdatingCurrent.isDateInYesterday(self as Date) {
            string = "Yesterday"
        } else {
            string = Utility.getStringFromDate(self, inFormat: "EEE, MMM d, yyyy")
        }
        return string
    }

    func getChatSectionDateStringFromDateTime() -> String {
        let now = Date()
        let date = self
        let yearDifference: Int   =  self.numberOfDifferenceUntilDateTimeWithUnit(.year, toDateTime: now)
        let monthDifference: Int  =  self.numberOfDifferenceUntilDateTimeWithUnit(.month, toDateTime: now)
        let dayDifference: Int    =  self.numberOfDifferenceUntilDateTimeWithUnit(.day, toDateTime: now)
        let hourDifference: Int   =  self.numberOfDifferenceUntilDateTimeWithUnit(.hour, toDateTime: now)
        let minuteDifference: Int =  self.numberOfDifferenceUntilDateTimeWithUnit(.minute, toDateTime: now)
        var timestamp: String?
        let formatter: DateFormatter = DateFormatter()
        formatter.timeZone =  NSTimeZone.local
        var strDate1: String? = ""
        var strDate2: String? = ""

        if (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 && hourDifference == 0 && minuteDifference == 0) {
            //"Just Now"
            timestamp = "Just Now"
        } else if (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 && hourDifference == 0 && minuteDifference < 60) {
            //"13 minutes ago"
            //timestamp = NSString(format:"%ld minutes ago", minuteDifference)
            if(date.is24HourTimeForDate() == true) {
                formatter.dateFormat = "HH:mm"
            } else {
                formatter.dateFormat = "h:mm a"
            }
            strDate1 = formatter.string(from: date)
            timestamp = "Today " + strDate1!
        } else if (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 && hourDifference == 1) {
            //"1 hour ago" EXACT
            // timestamp = "1 hour ago"
            if(date.is24HourTimeForDate() == true) {
                formatter.dateFormat = "HH:mm"
            } else {
                formatter.dateFormat = "h:mm a"
            }
            strDate1 = formatter.string(from: date)
            timestamp = "Today " + strDate1!
        } else if (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 && hourDifference < 24) {
            // "12 hours ago" , Today 05:00 AM

            if(date.is24HourTimeForDate() == true) {
                formatter.dateFormat = "HH:mm"
            } else {
                formatter.dateFormat = "h:mm a"
            }
            strDate1 = formatter.string(from: date)
            timestamp = "Today " + strDate1!
        } else {
            if (yearDifference == 0 && monthDifference == 0 && dayDifference == 1) {
                //"Yesterday 10:23 AM", "Yesterday 5:08 PM"
                if(date.is24HourTimeForDate() == true) {
                    formatter.dateFormat = "HH:mm"
                } else {
                    formatter.dateFormat = "h:mm a"
                }
                strDate1 = formatter.string(from: date)
                timestamp = "Yesterday " + strDate1!

            } else if (yearDifference == 0 && monthDifference == 0 && dayDifference < 7) {
                //"Tuesday 7:13 PM"
                formatter.dateFormat = "EEEE"
                strDate1 = formatter.string(from: date)
                if(date.is24HourTimeForDate() == true) {
                    formatter.dateFormat = "HH:mm"
                } else {
                    formatter.dateFormat = "h:mm a"
                }
                strDate2 = formatter.string(from: date)
                timestamp = strDate1! + " " + strDate2!

            } else if (yearDifference == 0) {
                //"Tue,Jan 4, 7:36 AM"
                formatter.dateFormat = "EE, MMM d,"
                formatter.dateFormat = "EE, MMM d,"
                strDate1 = formatter.string(from: date)
                if(date.is24HourTimeForDate() == true) {
                    formatter.dateFormat = "HH:mm"
                } else {
                    formatter.dateFormat = "h:mm a"
                }
                strDate2 = formatter.string(from: date)
                timestamp = strDate1! + " " +  strDate2!

            } else {
                //"Tue, Jan3, 2017, 4:50 AM"
                formatter.dateFormat = "EE, MMM d, yyyy,"
                strDate1 = formatter.string(from: date)
                if(date.is24HourTimeForDate() == true) {
                    formatter.dateFormat = "HH:mm"
                } else {
                    formatter.dateFormat = "h:mm a"
                }
                strDate2 = formatter.string(from: date)
                timestamp = strDate1! + " " + strDate2!
            }
        }
        return timestamp!
    }

    func numberOfDifferenceUntilDateTimeWithUnit(_ unit: Calendar.Component, toDateTime date: Date, inTimeZone timeZone: TimeZone? = nil) -> Int {
        var calendar = Calendar.current
        if let timeZone = timeZone {
            calendar.timeZone = timeZone
        }
        let component: Set<Calendar.Component> = [unit]
        let difference: DateComponents = calendar.dateComponents(component, from: self, to: date)
        if unit == .day {
            return difference.day!
        } else if unit == .month {
            return difference.month!
        } else if unit == .hour {
            return difference.hour!
        } else if unit == .minute {
            return difference.minute!
        } else if unit == .second {
            return difference.second!
        } else {
            return difference.year!
        }
    }
    /* Initializes a new Date() objext based on a date string, format, optional timezone and optional locale.
     
     - Returns: A Date() object if successfully converted from string or nil.
     */
    init?(fromString string: String, format: DateFormatType, timeZone: TimeZoneType = .local, locale: Locale = Foundation.Locale.current) {
        guard !string.isEmpty else {
            return nil
        }
        var string = string
        switch format {
        case .dotNet:
            let pattern = "\\\\?/Date\\((\\d+)(([+-]\\d{2})(\\d{2}))?\\)\\\\?/"
            let regex = try? NSRegularExpression(pattern: pattern)
            guard let match = regex?.firstMatch(in: string, range: NSRange(location: 0, length: string.utf16.count)) else {
                return nil
            }
            let dateString = (string as NSString).substring(with: match.range(at: 1))
            let interval = Double(dateString)! / 1000.0
            self.init(timeIntervalSince1970: interval)
            return
        case .rss, .altRSS:
            if string.hasSuffix("Z") {
                string = string.substring(to: string.index(string.endIndex, offsetBy: -1)).appending("GMT")
            }
        default:
            break
        }
        let formatter = Date.cachedFormatter(format.stringFormat, timeZone: timeZone.timeZone, locale: locale)
        guard let date = formatter.date(from: string) else {
            return nil
        }
        self.init(timeInterval: 0, since: date)
    }
    // MARK: Convert to String
    /// Converts the date to string using the short date and time style.
    func toString(style: DateStyleType = .short) -> String {
        switch style {
        case .short:
            return self.toString(dateStyle: .short, timeStyle: .short, isRelative: false)
        case .medium:
            return self.toString(dateStyle: .medium, timeStyle: .medium, isRelative: false)
        case .long:
            return self.toString(dateStyle: .long, timeStyle: .long, isRelative: false)
        case .full:
            return self.toString(dateStyle: .full, timeStyle: .full, isRelative: false)
        case .weekday:
            let weekdaySymbols = Date.cachedFormatter().weekdaySymbols!
            let string = weekdaySymbols[component(.weekday)!-1] as String
            return string
        case .shortWeekday:
            let shortWeekdaySymbols = Date.cachedFormatter().shortWeekdaySymbols!
            return shortWeekdaySymbols[component(.weekday)!-1] as String
        case .veryShortWeekday:
            let veryShortWeekdaySymbols = Date.cachedFormatter().veryShortWeekdaySymbols!
            return veryShortWeekdaySymbols[component(.weekday)!-1] as String
        case .month:
            let monthSymbols = Date.cachedFormatter().monthSymbols!
            return monthSymbols[component(.month)!-1] as String
        case .shortMonth:
            let shortMonthSymbols = Date.cachedFormatter().shortMonthSymbols!
            return shortMonthSymbols[component(.month)!-1] as String
        case .veryShortMonth:
            let veryShortMonthSymbols = Date.cachedFormatter().veryShortMonthSymbols!
            return veryShortMonthSymbols[component(.month)!-1] as String
        }
    }
    /// Converts the date to string based on a date format, optional timezone and optional locale.
    func toString(format: DateFormatType, timeZone: TimeZoneType = .local, locale: Locale = Locale.current) -> String {
        switch format {
        case .dotNet:
            let offset = Foundation.NSTimeZone.default.secondsFromGMT() / 3600
            let nowMillis = 1000 * self.timeIntervalSince1970
            return String(format: format.stringFormat, nowMillis, offset)
        default:
            break
        }
        let formatter = Date.cachedFormatter(format.stringFormat, timeZone: timeZone.timeZone, locale: locale)
        return formatter.string(from: self)
    }
    /// Converts the date to string based on DateFormatter's date style and time style with optional relative date formatting, optional time zone and optional locale.
    func toString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, isRelative: Bool = false, timeZone: Foundation.TimeZone = Foundation.NSTimeZone.local, locale: Locale = Locale.current) -> String {
        let formatter = Date.cachedFormatter(dateStyle, timeStyle: timeStyle, doesRelativeDateFormatting: isRelative, timeZone: timeZone, locale: locale)
        return formatter.string(from: self)
    }
    /// Converts the date to string based on a relative time language. i.e. just now, 1 minute ago etc...
    func toStringWithRelativeTime(strings: [RelativeTimeStringType: String]? = nil) -> String {

        let time = self.timeIntervalSince1970
        let now = Date().timeIntervalSince1970
        let isPast = now - time > 0

        let sec: Double = abs(now - time)
        let min: Double = round(sec/60)
        let hr: Double = round(min/60)
        let d: Double = round(hr/24)
         if sec < 60 {
            if sec < 10 {
                if isPast {
                    return strings?[.nowPast] ?? NSLocalizedString("just now", comment: "Date format")
                } else {
                    return strings?[.nowFuture] ?? NSLocalizedString("in a few seconds", comment: "Date format")
                }
            } else {
                let string: String
                if isPast {
                    string = strings?[.secondsPast] ?? NSLocalizedString("%.f seconds ago", comment: "Date format")
                } else {
                    string = strings?[.secondsFuture] ?? NSLocalizedString("in %.f seconds", comment: "Date format")
                }
                return String(format: string, sec)
            }
        }
        if min < 60 {
            if min == 1 {
                if isPast {
                    return strings?[.oneMinutePast] ?? NSLocalizedString("1 minute ago", comment: "Date format")
                } else {
                    return strings?[.oneMinuteFuture] ?? NSLocalizedString("in 1 minute", comment: "Date format")
                }
            } else {
                let string: String
                if isPast {
                    string = strings?[.minutesPast] ?? NSLocalizedString("%.f minutes ago", comment: "Date format")
                } else {
                    string = strings?[.minutesFuture] ?? NSLocalizedString("in %.f minutes", comment: "Date format")
                }
                return String(format: string, min)
            }
        }
        if hr < 24 {
            if hr == 1 {
                if isPast {
                    return strings?[.oneHourPast] ?? NSLocalizedString("last hour", comment: "Date format")
                } else {
                    return strings?[.oneHourFuture] ?? NSLocalizedString("next hour", comment: "Date format")
                }
            } else {
                let string: String
                if isPast {
                    string = strings?[.hoursPast] ?? NSLocalizedString("%.f hours ago", comment: "Date format")
                } else {
                    string = strings?[.hoursFuture] ?? NSLocalizedString("in %.f hours", comment: "Date format")
                }
                return String(format: string, hr)
            }
        }
        if d < 7 {
            if d == 1 {
                if isPast {
                    return strings?[.oneDayPast] ?? NSLocalizedString("yesterday", comment: "Date format")
                } else {
                    return strings?[.oneDayFuture] ?? NSLocalizedString("tomorrow", comment: "Date format")
                }
            } else {
                let string: String
                if isPast {
                    string = strings?[.daysPast] ?? NSLocalizedString("%.f days ago", comment: "Date format")
                } else {
                    string = strings?[.daysFuture] ?? NSLocalizedString("in %.f days", comment: "Date format")
                }
                return String(format: string, d)
            }
        }
        if d < 28 {
            if isPast {
                if compare(.isLastWeek) {
                    return strings?[.oneWeekPast] ?? NSLocalizedString("last week", comment: "Date format")
                } else {
                    let string = strings?[.weeksPast] ?? NSLocalizedString("%.f weeks ago", comment: "Date format")
                    return String(format: string, Double(abs(since(Date(), in: .week))))
                }
            } else {
                if compare(.isNextWeek) {
                    return strings?[.oneWeekFuture] ?? NSLocalizedString("next week", comment: "Date format")
                } else {
                    let string = strings?[.weeksFuture] ?? NSLocalizedString("in %.f weeks", comment: "Date format")
                    return String(format: string, Double(abs(since(Date(), in: .week))))
                }
            }
        }
        if compare(.isThisYear) {
            if isPast {
                if compare(.isLastMonth) {
                    return strings?[.oneMonthPast] ?? NSLocalizedString("last month", comment: "Date format")
                } else {
                    let string = strings?[.monthsPast] ?? NSLocalizedString("%.f months ago", comment: "Date format")
                    return String(format: string, Double(abs(since(Date(), in: .month))))
                }
            } else {
                if compare(.isNextMonth) {
                    return strings?[.oneMonthFuture] ?? NSLocalizedString("next month", comment: "Date format")
                } else {
                    let string = strings?[.monthsFuture] ?? NSLocalizedString("in %.f months", comment: "Date format")
                    return String(format: string, Double(abs(since(Date(), in: .month))))
                }
            }
        }
        if isPast {
            if compare(.isLastYear) {
                return strings?[.oneYearPast] ?? NSLocalizedString("last year", comment: "Date format")
            } else {
                let string = strings?[.yearsPast] ?? NSLocalizedString("%.f years ago", comment: "Date format")
                return String(format: string, Double(abs(since(Date(), in: .year))))
            }
        } else {
            if compare(.isNextYear) {
                return strings?[.oneYearFuture] ?? NSLocalizedString("next year", comment: "Date format")
            } else {
                let string = strings?[.yearsFuture] ?? NSLocalizedString("in %.f years", comment: "Date format")
                return String(format: string, Double(abs(since(Date(), in: .year))))
            }
        }
    }
    // MARK: Compare Dates
    /// Compares dates to see if they are equal while ignoring time.
    func compare(_ comparison: DateComparisonType) -> Bool {
        switch comparison {
        case .isToday:
            return compare(.isSameDay(as: Date()))
        case .isTomorrow:
            let comparison = Date().adjust(.day, offset: 1)
            return compare(.isSameDay(as: comparison))
        case .isYesterday:
            let comparison = Date().adjust(.day, offset: -1)
            return compare(.isSameDay(as: comparison))
        case .isSameDay(let date):
            return component(.year) == date.component(.year)
                && component(.month) == date.component(.month)
                && component(.day) == date.component(.day)
        case .isThisWeek:
            return self.compare(.isSameWeek(as: Date()))
        case .isNextWeek:
            let comparison = Date().adjust(.week, offset: 1)
            return compare(.isSameWeek(as: comparison))
        case .isLastWeek:
            let comparison = Date().adjust(.week, offset: -1)
            return compare(.isSameWeek(as: comparison))
        case .isSameWeek(let date):
            if component(.week) != date.component(.week) {
                return false
            }
            // Ensure time interval is under 1 week
            return abs(self.timeIntervalSince(date)) < Date.weekInSeconds
        case .isThisMonth:
            return self.compare(.isSameMonth(as: Date()))
        case .isNextMonth:
            let comparison = Date().adjust(.month, offset: 1)
            return compare(.isSameMonth(as: comparison))
        case .isLastMonth:
            let comparison = Date().adjust(.month, offset: -1)
            return compare(.isSameMonth(as: comparison))
        case .isSameMonth(let date):
            return component(.year) == date.component(.year) && component(.month) == date.component(.month)
        case .isThisYear:
            return self.compare(.isSameYear(as: Date()))
        case .isNextYear:
            let comparison = Date().adjust(.year, offset: 1)
            return compare(.isSameYear(as: comparison))
        case .isLastYear:
            let comparison = Date().adjust(.year, offset: -1)
            return compare(.isSameYear(as: comparison))
        case .isSameYear(let date):
            return component(.year) == date.component(.year)
        case .isInTheFuture:
            return self.compare(.isLater(than: Date()))
        case .isInThePast:
            return self.compare(.isEarlier(than: Date()))
        case .isEarlier(let date):
            return (self as NSDate).earlierDate(date) == self
        case .isLater(let date):
            return (self as NSDate).laterDate(date) == self
        case .isWeekday:
            return !compare(.isWeekend)
        case .isWeekend:
            let range = Calendar.current.maximumRange(of: Calendar.Component.weekday)!
            return (component(.weekday) == range.lowerBound || component(.weekday) == range.upperBound - range.lowerBound)
        }

    }
    // MARK: Adjust dates
    /// Creates a new date with adjusted components
    func adjust(_ component: DateComponentType, offset: Int) -> Date {
        var dateComp = DateComponents()
        switch component {
        case .second:
            dateComp.second = offset
        case .minute:
            dateComp.minute = offset
        case .hour:
            dateComp.hour = offset
        case .day:
            dateComp.day = offset
        case .weekday:
            dateComp.weekday = offset
        case .nthWeekday:
            dateComp.weekdayOrdinal = offset
        case .week:
            dateComp.weekOfYear = offset
        case .month:
            dateComp.month = offset
        case .year:
            dateComp.year = offset
        }
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    /// Return a new Date object with the new hour, minute and seconds values.
    func adjust(hour: Int?, minute: Int?, second: Int?, day: Int? = nil, month: Int? = nil) -> Date {
        var comp = Date.components(self)
        comp.month = month ?? comp.month
        comp.day = day ?? comp.day
        comp.hour = hour ?? comp.hour
        comp.minute = minute ?? comp.minute
        comp.second = second ?? comp.second
        return Calendar.current.date(from: comp)!
    }
    // MARK: Date for...
    func dateFor(_ type: DateForType) -> Date {
        switch type {
        case .startOfDay:
            return adjust(hour: 0, minute: 0, second: 0)
        case .endOfDay:
            return adjust(hour: 23, minute: 59, second: 59)
        case .startOfWeek:
            let offset = component(.weekday)!-1
            return adjust(.day, offset: -(offset))
        case .endOfWeek:
            let offset = 7 - component(.weekday)!
            return adjust(.day, offset: offset)
        case .startOfMonth:
            return adjust(hour: 0, minute: 0, second: 0, day: 1)
        case .endOfMonth:
            let month = (component(.month) ?? 0) + 1
            return adjust(hour: 0, minute: 0, second: 0, day: 0, month: month)
        case .tomorrow:
            return adjust(.day, offset: 1)
        case .yesterday:
            return adjust(.day, offset: -1)
        case .nearestMinute(let nearest):
            let minutes = (component(.minute)! + nearest/2) / nearest * nearest
            return adjust(hour: nil, minute: minutes, second: nil)
        case .nearestHour(let nearest):
            let hours = (component(.hour)! + nearest/2) / nearest * nearest
            return adjust(hour: hours, minute: 0, second: nil)
        }
    }
    // MARK: Time since...
    func since(_ date: Date, in component: DateComponentType) -> Int64 {
        switch component {
        case .second:
            return Int64(timeIntervalSince(date))
        case .minute:
            let interval = timeIntervalSince(date)
            return Int64(interval / Date.minuteInSeconds)
        case .hour:
            let interval = timeIntervalSince(date)
            return Int64(interval / Date.hourInSeconds)
        case .day:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .day, in: .era, for: self)
            let start = calendar.ordinality(of: .day, in: .era, for: date)
            return Int64(end! - start!)
        case .weekday:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .weekday, in: .era, for: self)
            let start = calendar.ordinality(of: .weekday, in: .era, for: date)
            return Int64(end! - start!)
        case .nthWeekday:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .weekdayOrdinal, in: .era, for: self)
            let start = calendar.ordinality(of: .weekdayOrdinal, in: .era, for: date)
            return Int64(end! - start!)
        case .week:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .weekOfYear, in: .era, for: self)
            let start = calendar.ordinality(of: .weekOfYear, in: .era, for: date)
            return Int64(end! - start!)
        case .month:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .month, in: .era, for: self)
            let start = calendar.ordinality(of: .month, in: .era, for: date)
            return Int64(end! - start!)
        case .year:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .year, in: .era, for: self)
            let start = calendar.ordinality(of: .year, in: .era, for: date)
            return Int64(end! - start!)
        }
    }
    // MARK: Extracting components
    func component(_ component: DateComponentType) -> Int? {
        let components = Date.components(self)
        switch component {
        case .second:
            return components.second
        case .minute:
            return components.minute
        case .hour:
            return components.hour
        case .day:
            return components.day
        case .weekday:
            return components.weekday
        case .nthWeekday:
            return components.weekdayOrdinal
        case .week:
            return components.weekOfYear
        case .month:
            return components.month
        case .year:
            return components.year
        }
    }
    func numberOfDaysInMonth() -> Int {
        let range = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: self)!
        return range.upperBound - range.lowerBound
    }
    func firstDayOfWeek() -> Int {
        let distanceToStartOfWeek = Date.dayInSeconds * Double(self.component(.weekday)! - 1)
        let interval: TimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek
        return Date(timeIntervalSinceReferenceDate: interval).component(.day)!
    }
    func lastDayOfWeek() -> Int {
        let distanceToStartOfWeek = Date.dayInSeconds * Double(self.component(.weekday)! - 1)
        let distanceToEndOfWeek = Date.dayInSeconds * Double(7)
        let interval: TimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek + distanceToEndOfWeek
        return Date(timeIntervalSinceReferenceDate: interval).component(.day)!
    }
    // MARK: Internal Components
    internal static func componentFlags() -> Set<Calendar.Component> { return [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.weekOfYear, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second, Calendar.Component.weekday, Calendar.Component.weekdayOrdinal, Calendar.Component.weekOfYear] }
    internal static func components(_ fromDate: Date) -> DateComponents {
        return Calendar.current.dateComponents(Date.componentFlags(), from: fromDate)
    }
    // MARK: Static Cached Formatters

    /// A cached static array of DateFormatters so that thy are only created once.
    private static func cachedDateFormatters() -> [String: DateFormatter] {
        struct Static {
            static var formatters: [String: DateFormatter]? = [String: DateFormatter]()
        }
        return Static.formatters!
    }
    /// Generates a cached formatter based on the specified format, timeZone and locale. Formatters are cached in a singleton array using hashkeys.
    private static func cachedFormatter(_ format: String = DateFormatType.standard.stringFormat, timeZone: Foundation.TimeZone = Foundation.TimeZone.current, locale: Locale = Locale.current) -> DateFormatter {
        let hashKey = "\(format.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
        var formatters = Date.cachedDateFormatters()
        if let cachedDateFormatter = formatters[hashKey] {
            return cachedDateFormatter
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.timeZone = timeZone
            formatter.locale = locale
            formatters[hashKey] = formatter
            return formatter
        }
    }
    /// Generates a cached formatter based on the provided date style, time style and relative date. Formatters are cached in a singleton array using hashkeys.
    private static func cachedFormatter(_ dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, doesRelativeDateFormatting: Bool, timeZone: Foundation.TimeZone = Foundation.NSTimeZone.local, locale: Locale = Locale.current) -> DateFormatter {
        var formatters = Date.cachedDateFormatters()
        let hashKey = "\(dateStyle.hashValue)\(timeStyle.hashValue)\(doesRelativeDateFormatting.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
        if let cachedDateFormatter = formatters[hashKey] {
            return cachedDateFormatter
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = dateStyle
            formatter.timeStyle = timeStyle
            formatter.doesRelativeDateFormatting = doesRelativeDateFormatting
            formatter.timeZone = timeZone
            formatter.locale = locale
            formatters[hashKey] = formatter
            return formatter
        }
    }
    func getDateOnly() -> Date {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateFormatType.isoDate.stringFormat
           let str = dateFormatter.string(from: self)
        let date = dateFormatter.date(from: str)
        return date!

    }

    func getDateInUTC() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //Input Format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let UTCDateString = dateFormatter.string(from: self)
        let UTCDate = dateFormatter.date(from: UTCDateString)
        return UTCDate!
    }

    // MARK: Intervals In Seconds
    internal static let minuteInSeconds: Double = 60
    internal static let hourInSeconds: Double = 3600
    internal static let dayInSeconds: Double = 86400
    internal static let weekInSeconds: Double = 604800
    internal static let yearInSeconds: Double = 31556926
}
