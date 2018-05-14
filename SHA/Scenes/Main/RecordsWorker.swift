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
    
    func increment(counter: Record.Counters, for date: RecordDate, completionHandler: @escaping (Record) -> Void) {
        
    }
}


/*
 currentRecord = records.first(where: { dateFormatter.string(from: $0.date) == today })
 }
 }
 var currentRecord: Record!
 
 // MARK: - Records
 
 func fetchRecord(request: Main.FetchRecord.Request) {
 worker.fetchRecords { records in
 //self.records = records.count > 0 ? records : [Record()]
 // - if no today record, make one
*/
