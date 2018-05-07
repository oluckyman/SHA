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
    func fetchRecords(request: Main.FetchRecords.Request)
}

protocol MainDataStore {
    //var name: String { get set }
}

class MainInteractor: MainBusinessLogic, MainDataStore {
    var presenter: MainPresentationLogic?
    var worker = RecordsWorker()
    
    // MARK: - Records
    
    func fetchRecords(request: Main.FetchRecords.Request) {
        worker.fetchRecords {
            let response = Main.FetchRecords.Response()
            presenter?.presentRecord(response: response)
        }
    }
}
