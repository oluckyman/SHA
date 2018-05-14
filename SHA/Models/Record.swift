//
//  Record.swift
//  SHA
//
//  Created by Ilyá Belsky on 5/9/18.
//  Copyright © 2018 Ilyá Belsky. All rights reserved.
//

import Foundation

struct Record: Equatable {
    var date: RecordDate
    var full: Int
    var express: Int
}

extension Record {
    init() {
        self.date = RecordDate()
        self.full = 0
        self.express = 0
    }
}

//func ==(a: Record, b: Record) -> Bool {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd"
//    return
//        a.express == b.express &&
//        b.full == b.full &&
//        dateFormatter.string(from: a.date) == dateFormatter.string(from: b.date)
//}
