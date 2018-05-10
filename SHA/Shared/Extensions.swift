//
//  Extensions.swift
//  SHA
//
//  Created by Ilyá Belsky on 5/9/18.
//  Copyright © 2018 Ilyá Belsky. All rights reserved.
//

import Foundation


extension Date {
    /// Creates a new instance by decoding from the string.
    ///
    /// This initializer returns nil if reading from the string fails, or
    /// if the string cannot be parsed otherwise invalid.
    ///
    /// - Parameter from: Date represented in string format `yyyy-MM-dd`
    init?(from dateString: String)  {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            self.init(timeInterval: 0, since: date)
        } else {
            return nil
        }
    }
}
