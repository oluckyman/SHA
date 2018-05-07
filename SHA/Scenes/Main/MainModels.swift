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

    enum FetchRecords {
        struct Request { }
        struct Response { }
        struct ViewModel {
            var date: String
            var full: String
            var express: String
        }
    }
}
