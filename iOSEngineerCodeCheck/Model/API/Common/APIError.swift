//
//  APIError.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/23.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

enum APIError: Error {
    
    case forbidden
    case serviceUnavailable
    case unknown
}

extension APIError {
    
    /// エラーの詳細メッセージ
    var description: String {
        
        switch self {
        case .forbidden:
            return "アクセスが拒否されています。"
        case .serviceUnavailable:
            return "現在サービスをご利用いただくことができません。時間を置いて再度お試しください。"
        case .unknown:
            return "不明なエラーです。開発者にお問合せください。"
        }
    }
}
