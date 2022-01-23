//
//  SearchViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxCocoa
import RxDataSources
import RxOptional
import RxSwift

protocol SearchViewModelInput {
    var searchWordObserver: AnyObserver<String?> { get }   // 検索ワード
}

protocol SearchViewModelOutput {
    var dataRelay: BehaviorRelay<[SearchResultSectionModel]> { get }
    var showError: PublishRelay<APIError> { get }
}

final class SearchViewModel: SearchViewModelInput, SearchViewModelOutput {
    
    var input: SearchViewModelInput { return self }
    var output: SearchViewModelOutput { return self }
    private let disposeBag = DisposeBag()
    private var sectionModel: [SearchResultSectionModel] = []
    
    // Input
    private let _searchWord = PublishRelay<String?>()
    lazy var searchWordObserver: AnyObserver<String?> = .init { [weak self] event in
        guard let element = event.element
        else {
            return
        }
        self?._searchWord.accept(element)
    }
    
    // Output
    lazy var dataRelay = BehaviorRelay<[SearchResultSectionModel]>(value: [])
    lazy var showError = PublishRelay<APIError>()
    
    // MARK: -
    
    init(searchButtonTap: Signal<Void>) {
        
        // RxDataSources
        Observable.deferred { () -> Observable<[SearchResultSectionModel]> in
            return Observable.just(self.sectionModel)
        }.bind(to: dataRelay)
        .disposed(by: disposeBag)
        
        // 検索するボタンが押される → 入力された文字からリポジトリを検索する処理
        searchButtonTap.asObservable()
            .withLatestFrom(_searchWord)
            .filterNil()
            .distinctUntilChanged()
            .flatMapLatest { searchWord -> Observable<Result<[RepositoryCodable], APIError>> in
                RepositoryAPI.shared.rx.getRepositories(by: searchWord)
            }
            .flatMapLatest { [weak self] result -> Observable<[SearchResultSectionModel]> in
                guard let self = self
                else {
                    return Observable.just([])
                }
                
                switch result {
                case .success(let repositories):
                    let cellModels = repositories.compactMap { repository in
                        SearchResultCellModel(repository: repository)
                    }
                    self.sectionModel = [SearchResultSectionModel(identity: 0, items: cellModels)]
                    return Observable.just(self.sectionModel)
                case .failure(let error):
                    // エラーが起きている通知を送る
                    self.showError.accept(error)
                    return Observable.just([])
                }
            }
            .bind(to: dataRelay)
            .disposed(by: disposeBag)
    }
}
