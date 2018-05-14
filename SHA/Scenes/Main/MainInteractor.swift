//
//  MainInteractor.swift
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


protocol MainBusinessLogic {
    func fetchRecord(request: Main.FetchRecord.Request)
    func incrementFull(request: Main.IncrementFull.Request)
    func resetFull(request: Main.ResetFull.Request)
    func navigateBack(request: Main.NavigateBack.Request)
}

protocol MainDataStore {
    var currentDate: RecordDate { get }
    var records: [Record] { get }
//    var currentRecord: Record! { get }
}

class MainInteractor: MainBusinessLogic, MainDataStore {
    var presenter: MainPresentationLogic?
    var worker = RecordsWorker(recordsStore: RecordsMemStore())
    
    var currentDate = RecordDate()
    
    var records: [Record] = [] {
        didSet {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            let today = dateFormatter.string(from: Date())
//            currentRecord = records.first(where: { dateFormatter.string(from: $0.date) == today })
        }
    }
//    var currentRecord: Record!
    
    // MARK: - Records
    
    func fetchRecord(request: Main.FetchRecord.Request) {
        worker.fetchRecord(for: currentDate, completionHandler: { record in
            let response = Main.FetchRecord.Response(record: record)
            self.presenter?.presentRecord(response: response)
        })
    }

    // MARK: - Counters
    
    func incrementFull(request: Main.IncrementFull.Request) {
        // TODO: as worker fot increment with current date and in completion handler call presenter
        // rewrite tests accordingly
//        currentRecord.full += 1
//        let response = Main.FetchRecord.Response(record: currentRecord)
//        presenter?.presentRecord(response: response)
    }
    
    func resetFull(request: Main.ResetFull.Request) {
//        currentRecord.full = 0
//        let response = Main.FetchRecord.Response(record: currentRecord)
//        presenter?.presentRecord(response: response)
    }
    
    // MARK: - Navigation
    
    func navigateBack(request: Main.NavigateBack.Request) {
//        currentRecord.date = dayBefore(currentRecord.date)
//        let response = Main.FetchRecord.Response(record: currentRecord)
//        presenter?.presentRecord(response: response)
    }
    
//    private func dayBefore(_ date: Date) -> Date {
//        let oneDayInterval = 60 * 60 * 24 * 1.0
//        return Date(timeInterval: -oneDayInterval, since: date)
//    }
    
}
