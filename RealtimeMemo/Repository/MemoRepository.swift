//
//  MemoRepository.swift
//  RealtimeMemo
//
//  Created by date on 2018/02/04.
//  Copyright © 2018年 batumaru. All rights reserved.
//

import UIKit
import Firebase

final class MemoRepository {

    static let identifier = "memo"
    
    static func gets(completion: @escaping (_ memos: [Memo], _ error: Error?) -> Void) {
        Firestore.firestore().collection(identifier).getDocuments(completion: { (query, error) in
            let memos = query?.documents
                .flatMap { $0.data()["description"] as? String }
                .map { Memo(description: $0) } ?? []
            completion(memos, error)
        })
    }
    
    static func save(description: String, completion: @escaping (_ error: Error?) -> Void) {
        let data = ["description": description]
        Firestore.firestore().collection(identifier).addDocument(data: data) { error in
            completion(error)
        }
    }
}
