//
//  DetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var stargazersLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!
    
    var vc1: SearchViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repository = vc1?.repositories[vc1?.index ?? 0]
        languageLabel.text = "Written in \(repository?.language ?? "--")"
        stargazersLabel.text = "\(repository?.stargazersCount ?? 0) stars"
        watchersLabel.text = "\(repository?.watchersCount ?? 0) watchers"
        forksLabel.text = "\(repository?.forksCount ?? 0) forks"
        issuesLabel.text = "\(repository?.openIssuesCount ?? 0) open issues"
        getImage()
    }
    
    func getImage() {
        
        let repository = vc1?.repositories[vc1?.index ?? 0]
        titleLabel.text = repository?.fullName
        
        let owner = repository?.owner
        guard let imageUrl = owner?.avatarUrl,
              let url = URL(string: imageUrl)
        else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self.avatarImageView.image = UIImage(data: data)
            }
        }
        .resume()
    }
}
