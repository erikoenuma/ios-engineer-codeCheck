//
//  RepositoryCodable.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

/// 検索結果のリポジトリ
struct RepositoryCodable: Codable {
    
    let fullName: String
    let language: String?
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: OwnerCodable
    let htmlURL: String
    
    enum CodingKeys: String, CodingKey {
        
        case fullName = "full_name"
        case language
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case owner
        case htmlURL = "html_url"
    }
}
