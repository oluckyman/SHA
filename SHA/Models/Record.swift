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
    enum Counters: String {
        case full
        case express
    }
    
    init() {
        self.date = RecordDate()
        self.full = 0
        self.express = 0
    }
}
