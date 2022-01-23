//
//  HTTPStatusCode.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/23.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

enum HTTPStatusCode: Int {
    
    case unknown = 0
    
    // 2xx 成功
    case success = 200
    
    // 3xx リダイレクション
    case notModified = 304        // 更新されていない
    
    // 4xx クライアントエラー
    case forbidden = 403          // アクセス拒否
    case validationFailed = 422    // リクエストは適正だが意味が異なるためサーバが返すことが出来ない
    
    // 5xx サーバーエラー
    case serviceUnavailable = 503
}

extension HTTPStatusCode {
    
    static func create(httpURLResponse: HTTPURLResponse?) -> HTTPStatusCode {
        if let statusCode = HTTPStatusCode(rawValue: httpURLResponse?.statusCode ?? 0) {
            return statusCode
        } else {
            return HTTPStatusCode.unknown
        }
    }
}

extension HTTPStatusCode {
    
    func getAPIError() -> APIError {
        
        switch self {
        case .forbidden:
            return .forbidden
        case .serviceUnavailable:
            return .serviceUnavailable
        default:
            return .unknown
        }
    }
}
