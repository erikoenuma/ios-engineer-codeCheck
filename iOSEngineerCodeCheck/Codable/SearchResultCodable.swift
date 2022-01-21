//
//  SearchResultCodable.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

/// 検索結果Codable
struct SearchResultCodable: Codable {
    
    let items: [RepositoryCodable]
}
