//
//  DetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Kingfisher
import RxCocoa
import RxSwift
import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var stargazersLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!
    
    private let viewModel = DetailViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindOutputStream()
    }
    
    static func configure(repository: RepositoryCodable) -> DetailViewController {
        let vc = UIStoryboard(name: "DetailView", bundle: nil).instantiateInitialViewController() as! DetailViewController
        vc.viewModel.input.configureWith(repository: repository)
        return vc
    }
    
    private func bindOutputStream() {
        
        viewModel.output.titleText
            .bind(to: titleLabel.rx.text.asObserver())
            .disposed(by: disposeBag)
        
        viewModel.output.languageText
            .bind(to: languageLabel.rx.text.asObserver())
            .disposed(by: disposeBag)
        
        viewModel.output.stargazersCountText
            .bind(to: stargazersLabel.rx.text.asObserver())
            .disposed(by: disposeBag)
        
        viewModel.output.forksCountText
            .bind(to: forksLabel.rx.text.asObserver())
            .disposed(by: disposeBag)
        
        viewModel.output.watchersCountText
            .bind(to: watchersLabel.rx.text.asObserver())
            .disposed(by: disposeBag)
        
        viewModel.output.issuesCountText
            .bind(to: issuesLabel.rx.text.asObserver())
            .disposed(by: disposeBag)
        
        viewModel.output.avatarImageURL
            .subscribe(onNext: { [weak self] url in
                self?.avatarImageView.kf.setImage(with: url)
            })
            .disposed(by: disposeBag)
    }
}
