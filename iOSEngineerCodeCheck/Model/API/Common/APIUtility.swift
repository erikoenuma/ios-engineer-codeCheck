//
//  APIUtility.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/23.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Alamofire
import Foundation

final class APIUtility {
    
    /// APIの結果をプリントする
    static func apiResponsePrint(response: AFDataResponse<Data?>) {
        print("========== API ==========")
        print("[URL:\(response.request?.httpMethod ?? "empty")]", response.response?.url ?? "empty")
        print("[StatusCode]", response.response?.statusCode ?? 0)
        print("[data]")
    }
}
