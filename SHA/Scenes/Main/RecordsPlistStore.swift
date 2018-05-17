//
//  RecordsPlistStore.swift
//  SHA
//
//  Created by Ilyá Belsky on 5/17/18.
//  Copyright © 2018 Ilyá Belsky. All rights reserved.
//

import Foundation

class RecordsPlistStore {
    let plistPath: String
    
    init(plist fileName: String = "records.plist") {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        plistPath = documentPath.appendingPathComponent(fileName)
    }
}

extension RecordsPlistStore: RecordsStore {
    
    func fetchRecords(completionHandler: @escaping ([Record]) -> Void) {
        let recordsPlist = (NSArray(contentsOfFile: plistPath) ?? []) as! [PlistDictionary]
        let records = recordsPlist.map(Record.init)
        completionHandler(records)
    }
    
    func update(record: Record, completionHanler: @escaping (Record) -> Void) {
        
    }
}
