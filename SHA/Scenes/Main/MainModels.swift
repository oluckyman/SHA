//
//  MainModels.swift
//  SHA
//
//  Created by Ilyá Belsky on 4/25/18.
//  Copyright (c) 2018 Ilyá Belsky. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Main {
    // MARK: - Use cases

    enum FetchRecord {
        struct Request { }
        struct Response {
            var record: Record
        }
        struct ViewModel {
            var date: String
            var full: String
            var express: String
        }
    }
    
    enum Increment {
        struct Request {
            var counter: Record.Counter
        }
    }
    
    enum Reset {
        struct Request {
            var counter: Record.Counter
        }
    }
    
    enum Navigate {
        enum Direction {
            case prev
            case next
        }
        struct Request {
            var direction: Direction
        }
    }
    
    enum Share {
        struct Request {}
        struct Response {
            var date: RecordDate
            var records: [Record]
        }
        struct ViewModel {
            var url: URL
            var message: String
        }
    }
}
