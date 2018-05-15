//
//  RecordsMemStore.swift
//  SHA
//
//  Created by Ilyá Belsky on 5/7/18.
//  Copyright © 2018 Ilyá Belsky. All rights reserved.
//

import Foundation

class RecordsMemStore: RecordsStore {
    var records: [Record] = []

    func fetchRecords(completionHandler: @escaping ([Record]) -> Void) {
        completionHandler(records)
    }
    
    func update(record: Record, completionHanler: @escaping (Record) -> Void) {
        // do update here
        completionHanler(record)
//        if let record = records.first(where: { $0.date == record.date }) {
//
//        }
//
//        <#code#>
    }
}
