//
//  MemoViewModel.swift
//  macOSTest
//
//  Created by 한지석 on 2023/07/13.
//

import Foundation
import CloudKit

struct Memo {
    let id: UUID
    let createdAt: Date
    let text: String
}

final class CloudManager: ObservableObject {
    
    private var container = CKContainer(identifier: "iCloud.macOSTest")

    
    func fetchMemo() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Memo", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.database = container.privateCloudDatabase

        operation.recordMatchedBlock = { resultId, result in
            switch result {
            case .success(let record):
                guard let text = record["text"] as? String,
                      let createdAt = record["createdAt"] as? Date
                else { return }
                print("@Log record - \(text), \(createdAt)")
            case .failure(let error):
                print("@Log error - \(error.localizedDescription)")
            }
        }

        operation.queryResultBlock = { result in
            print("@Log queryResult - \(result)")
            switch result {
            case .success(let a):
                print("@Log a - \(a)")
            case .failure(let error):
                print("@Log error - \(error.localizedDescription)")
            }
        }

        operation.start()
    }

        
}

//let query = CKQuery(recordType: "Memo", predicate: NSPredicate(value: true))
//query.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
//
//datebase.fetch(withQuery: query) { result in
//    switch result {
//    case .success(let result):
//        print("@Log - \(result)")
//        break
//    case .failure(let error):
//        print(error.localizedDescription)
//    }
//}



//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: "Memo", predicate: predicate)
//        query.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
//        let queryOperation = CKQueryOperation(query: query)
//        var memo: [Memo] = []
//
//        queryOperation.recordMatchedBlock = { (recordId, result) in
//            switch result {
//            case .success(let record):
//                guard let text = record["text"] else { return }
//                print(text)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        queryOperation.queryResultBlock = { result in
//            print(result)
//        }
//  func addTask(_ task: String, completionHandler: @escaping (CKRecord?, FetchError) -> Void) {
//    ...
//  }
//
//  func deleteRecord(record: CKRecord, completionHandler: @escaping (FetchError) -> Void) {
//    ...
//  }
//
//  func updateTask(_ task: CKRecord, completionHandler: @escaping (CKRecord?, FetchError) -> Void) {
//    ...
//  }

