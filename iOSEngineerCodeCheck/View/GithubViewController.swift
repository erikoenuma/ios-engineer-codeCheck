//
//  GithubViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/24.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
import WebKit

final class GithubViewController: UIViewController {
    
    private let githubView = WKWebView(frame: .zero)
    var url: URL?
    
    override func loadView() {
        self.view = githubView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showPage()
    }
    
    private func showPage() {
        
        guard let url = url else { return }
        githubView.load(URLRequest(url: url))
    }
}
