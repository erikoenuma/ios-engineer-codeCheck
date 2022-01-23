//
//  SearchResultSectionModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxDataSources

/// 検索結果のtableViewに表示するデータ
struct SearchResultCellModel: IdentifiableType, Equatable {
    
    static func == (lhs: SearchResultCellModel, rhs: SearchResultCellModel) -> Bool {
        lhs.identity == rhs.identity
    }
    
    var repository: RepositoryCodable
    typealias Identity = String
    
    var identity: String {
        return repository.fullName
    }
}

struct SearchResultSectionModel: AnimatableSectionModelType {
    typealias Identity = Int
    typealias Item = SearchResultCellModel
    
    let identity: Int
    var items: [Item]
    
    init(identity: Int, items: [Item]) {
        self.items = items
        self.identity = identity
    }
    
    init(original: SearchResultSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
