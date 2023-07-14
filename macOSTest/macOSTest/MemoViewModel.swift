//
//  MemoViewModel.swift
//  macOSTest
//
//  Created by 한지석 on 2023/07/13.
//

import Foundation
import CloudKit

struct Memo: Identifiable {
    let id: UUID
    let createdAt: Date
    let text: String
}

struct Menu: Identifiable {
    let id = UUID().uuidString
    let name: String
}

final class ListViewModel: ObservableObject {
    var menu: [Menu] = []
    
    init() {
        menu = [
            Menu(name: "아이디어 노트"),
            Menu(name: "보관함"),
            Menu(name: "휴지통")
        ]
    }
    
    
}

final class CloudManager: ObservableObject {
    
    private var container = CKContainer(identifier: "iCloud.macOSTest")
    @Published var memo: [Memo] = []

//    async throws -> [Memo]
    func fetchMemo(_ completion: @escaping ([Memo]) -> ()) {
        var memo: [Memo] = []
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Memo", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        let operation = CKQueryOperation(query: query)
        operation.database = container.privateCloudDatabase
        
        operation.queryResultBlock = { result in
            switch result {
            case .success(_):
                completion(memo)
            case .failure(let error):
                print("@Log - \(error.localizedDescription)")
            }
        }
        
        operation.recordMatchedBlock = { resultId, result in
            switch result {
            case .success(let record):
                guard let text = record["text"] as? String,
                      let createdAt = record["createdAt"] as? Date
                else { return }
                print("@Log - \(text), \(createdAt)")
                memo.append(Memo(id: UUID(), createdAt: createdAt, text: text))
                
            case .failure(let error):
                print("@Log error - \(error.localizedDescription)")
            }
//            completion(memo)
        }
        operation.start()
    }
    
    func temp() {
        fetchMemo { memo in
            self.memo = memo
        }
    }
    
//    operation.recordMatchedBlock = { resultId, result in
//        switch result {
//        case .success(let record):
//            guard let text = record["text"] as? String,
//                  let createdAt = record["createdAt"] as? Date
//            else { return }
//            print("@Log - \(text), \(createdAt)")
//            memo.append(Memo(id: UUID(), createdAt: createdAt, text: text))
//        case .failure(let error):
//            print("@Log error - \(error.localizedDescription)")
//        }
//    }
//    var chartRequest = MusicCatalogChartsRequest(types: [Song.self])
//    chartRequest.limit = 10
//    let chartResponse = try await chartRequest.response().songCharts[0].items
//    return chartResponse.songToMusic()

    
//    func getMemo(text: String, createdAt: Date) -> [Memo] {
//        var memo: [Memo] = []
//        memo.append(Memo(id: UUID(), createdAt: createdAt, text: text))
//        print("@Log - \(memo)")
//        return memo
//    }

        
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

