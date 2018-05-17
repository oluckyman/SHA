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
    enum Counter: String {
        case full
        case express
    }
    init() {
        self.date = RecordDate()
        self.full = 0
        self.express = 0
    }
}

// Mark: - Plist Setup

extension Record {
    private enum Keys: String, PlistKey {
        case date
        case full
        case express
    }
    
    init(plist: PlistDictionary) {
        self.date = RecordDate(from: plist.value(forKey: Keys.date))!
        self.full = plist.value(forKey: Keys.full)
        self.express = plist.value(forKey: Keys.express)
    }
}


typealias PlistDictionary = [String: AnyObject]
protocol PlistKey: RawRepresentable {}
protocol PlistValue {}
extension Int: PlistValue {}
extension String: PlistValue {}


extension Dictionary where Value: AnyObject {
    func value<V: PlistValue, K: PlistKey>(forKey key: K) -> V where K.RawValue == String {
        return self[key.rawValue as! Key] as! V
    }
}
