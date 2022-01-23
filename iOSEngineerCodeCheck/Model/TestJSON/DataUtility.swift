//
//  DataUtility.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/24.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class DataUtility {
    
    static func loadJson(filename: String) -> Data? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }
}
