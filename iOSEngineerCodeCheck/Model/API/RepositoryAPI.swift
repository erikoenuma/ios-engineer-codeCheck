//
//  RepositoryAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class RepositoryAPI {
    
    private init() {}
    static let shared = RepositoryAPI()
    
    func searchRepositories(by searchWord: String,
                            completion: ((Result<[RepositoryCodable], Error>) -> Void)?) {
        
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)")
        else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion?(.failure(error))
            }
            
            guard let data = data
            else {
                return
            }
            do {
                let searchResult = try JSONDecoder().decode(SearchResultCodable.self, from: data)
                completion?(.success(searchResult.items))
            } catch {
                completion?(.failure(error))
            }
        }
        task.resume()
    }
}

extension RepositoryAPI: ReactiveCompatible {}

// Reactive Programmingを行うための拡張
extension Reactive where Base: RepositoryAPI {
    
    func getRepositories(by searchWord: String) -> Observable<Result<[RepositoryCodable], Error>> {
        return Observable.create { observer in
            RepositoryAPI.shared.searchRepositories(by: searchWord) { result in
                observer.onNext(result)
            }
            return Disposables.create()
        }.share(replay: 1, scope: .whileConnected)
    }
}
