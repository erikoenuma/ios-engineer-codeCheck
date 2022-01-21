//
//  DetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var stargazersLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    
    var vc1: SearchViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repository = vc1.repositories[vc1.index]
        languageLabel.text = "Written in \(repository.language ?? "--")"
        stargazersLabel.text = "\(repository.stargazersCount) stars"
        watchersLabel.text = "\(repository.watchersCount) watchers"
        forksLabel.text = "\(repository.forksCount) forks"
        issuesLabel.text = "\(repository.openIssuesCount) open issues"
        getImage()
    }
    
    func getImage(){
        
        let repository = vc1.repositories[vc1.index]
        titleLabel.text = repository.fullName
        
        let owner = repository.owner
        let imageUrl = owner.avatarUrl
        URLSession.shared.dataTask(with: URL(string: imageUrl)!) { (data, response, error) in
            let image = UIImage(data: data!)!
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
        .resume()
    }
}
