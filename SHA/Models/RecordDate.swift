//
//  RecordDate.swift
//  SHA
//
//  Created by Ilyá Belsky on 5/14/18.
//  Copyright © 2018 Ilyá Belsky. All rights reserved.
//

import Foundation

class RecordDate {
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var rawDate: Date
    
    init(from date: Date = Date()) {
        rawDate = date
    }
    
    /// Creates a new instance by decoding from the string.
    ///
    /// This initializer returns nil if reading from the string fails, or
    /// if the string cannot be parsed otherwise invalid.
    ///
    /// - Parameter from: Date represented in string format `yyyy-MM-dd`
    init?(from dateString: String)  {
        if let date = formatter.date(from: dateString) {
            rawDate = date
        } else {
            return nil
        }
    }
    
    func yesterday() -> RecordDate {
        let oneDayInterval = 60 * 60 * 24 * 1.0
        return RecordDate(from: Date(timeInterval: -oneDayInterval, since: rawDate))
    }

    func tomorrow() -> RecordDate {
        let oneDayInterval = 60 * 60 * 24 * 1.0
        return RecordDate(from: Date(timeInterval: oneDayInterval, since: rawDate))
    }
}

extension RecordDate : CustomStringConvertible {
    var description: String {
        return formatter.string(from: rawDate)
    }
}

extension RecordDate : Equatable {
    static func == (lhs: RecordDate, rhs: RecordDate) -> Bool {
        return lhs.description == rhs.description
    }
}

