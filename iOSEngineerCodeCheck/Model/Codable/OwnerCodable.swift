//
//  OwnerCodable.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

/// リポジトリの中のオーナー
struct OwnerCodable: Codable {
    
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        
        case avatarUrl = "avatar_url"
    }
}
