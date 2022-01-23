//
//  ExtensionUIViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/23.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// APIのエラーメッセージを表示
    func showErrorMessage(of error: APIError) {
        
        let alert = UIAlertController(title: "エラー", message: error.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
}
