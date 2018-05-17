//
//  RecordsWorker.swift
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

protocol RecordsStore {
    func fetchRecords(completionHandler: @escaping ([Record]) -> Void)
    func update(record: Record, completionHanler: @escaping (Record) -> Void)
}

class RecordsWorker {
    var recordsStore: RecordsStore
    
    init(recordsStore: RecordsStore) {
        self.recordsStore = recordsStore
    }
    
    func fetchRecord(for date: RecordDate, completionHandler: @escaping (Record) -> Void) {
        recordsStore.fetchRecords { records in
            let record = records.first(where: { $0.date == date }) ?? Record(date: date, full: 0, express: 0)
            completionHandler(record)
        }
    }
    
    func fetchRecords(forMonthWith date: RecordDate, completionHandler: @escaping ([Record]) -> Void) {
        let cal = Calendar.current
        recordsStore.fetchRecords { records in
            let recordsToReport = records.filter {
                cal.component(.year, from: $0.date.rawDate) == cal.component(.year, from: date.rawDate) &&
                cal.component(.month, from: $0.date.rawDate) == cal.component(.month, from: date.rawDate)
            }
            completionHandler(recordsToReport)
        }
    }
    
    func increment(counter: Record.Counter, for date: RecordDate, completionHandler: @escaping (Record) -> Void) {
        fetchRecord(for: date) { record in
            var newRecord = Record(date: date, full: record.full, express: record.express)
            switch counter {
            case .full:
                newRecord.full += 1
            case .express:
                newRecord.express += 1
            }
            self.recordsStore.update(record: newRecord, completionHanler: completionHandler)
        }
    }
    
    func reset(counter: Record.Counter, for date: RecordDate, completionHandler: @escaping (Record) -> Void) {
        fetchRecord(for: date) { record in
            var newRecord = Record(date: date, full: record.full, express: record.express)
            switch counter {
            case .full:
                newRecord.full = 0
            case .express:
                newRecord.express = 0
            }
            self.recordsStore.update(record: newRecord, completionHanler: completionHandler)
        }
    }
}
