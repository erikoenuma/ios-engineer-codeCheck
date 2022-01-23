//
//  DetailViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/23.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxOptional
import RxRelay
import RxSwift

protocol DetailViewModelInput {
    func configureWith(repository: RepositoryCodable)
}

protocol DetailViewModelOutput {
    var titleText: BehaviorRelay<String> { get }
    var languageText: BehaviorRelay<String> { get }
    var stargazersCountText: BehaviorRelay<String> { get }
    var watchersCountText: BehaviorRelay<String> { get }
    var forksCountText: BehaviorRelay<String> { get }
    var issuesCountText: BehaviorRelay<String> { get }
    var avatarImage: BehaviorRelay<UIImage> { get }
}

final class DetailViewModel: DetailViewModelInput, DetailViewModelOutput {
    
    var input: DetailViewModelInput { return self }
    var output: DetailViewModelOutput { return self }
    private let disposeBag = DisposeBag()
    // UIImageを取得するURL
    private var imageURLString = PublishRelay<String>()
    
    // Input
    func configureWith(repository: RepositoryCodable) {
        
        titleText.accept(repository.fullName)
        languageText.accept("Written in \(repository.language ?? "--")")
        stargazersCountText.accept("\(repository.stargazersCount) stars")
        watchersCountText.accept("\(repository.watchersCount) watchers")
        forksCountText.accept("\(repository.forksCount) forks")
        issuesCountText.accept("\(repository.openIssuesCount) open issues")
        self.imageURLString.accept(repository.owner.avatarUrl)
    }
    
    // Output
    lazy var titleText = BehaviorRelay<String>(value: "")
    lazy var languageText = BehaviorRelay<String>(value: "")
    lazy var stargazersCountText = BehaviorRelay<String>(value: "")
    lazy var watchersCountText = BehaviorRelay<String>(value: "")
    lazy var forksCountText = BehaviorRelay<String>(value: "")
    lazy var issuesCountText = BehaviorRelay<String>(value: "")
    lazy var avatarImage = BehaviorRelay<UIImage>(value: UIImage())
    
    // MARK: -
    
    init() {
        
        imageURLString
            .map { URL(string: $0) }
            .filterNil()
            .flatMapLatest { url in
                ImageAPI.shared.rx.getImage(url: url)
            }
            .flatMapLatest { result -> Observable<UIImage> in
                
                switch result {
                case .success(let image):
                    return Observable.just(image)
                case .failure(let error):
                    print(error.localizedDescription)
                    return Observable.just(UIImage())
                }
            }
            .bind(to: avatarImage)
            .disposed(by: disposeBag)
    }
}
