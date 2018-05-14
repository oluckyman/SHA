//
//  RecordsMemStore.swift
//  SHA
//
//  Created by Ilyá Belsky on 5/7/18.
//  Copyright © 2018 Ilyá Belsky. All rights reserved.
//

import Foundation

class RecordsMemStore: RecordsStore {
    let records: [Record] = []

    func fetchRecords(completionHandler: @escaping ([Record]) -> Void) {
        completionHandler(records)
    }
}
