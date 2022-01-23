//
//  RepositoryAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Alamofire
import Foundation
import RxCocoa
import RxSwift

final class RepositoryAPI {
    
    private init() {}
    static let shared = RepositoryAPI()
    
    func searchRepositories(by searchWord: String,
                            completion: ((Result<[RepositoryCodable], APIError>) -> Void)?) {
        
        let header = HTTPHeaders([HTTPHeader(name: "accept", value: "application/vnd.github.v3+json")])
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)")
        else {
            completion?(.failure(.unknown))
            return
        }
        
        AF.request(url, method: .get, headers: header).response { response in
            
            APIUtility.apiResponsePrint(response: response)
            
            switch response.result {
                
            case .failure(let error):
                print("[API ERROR]", error.localizedDescription)
                let HTTPStatusCode = HTTPStatusCode.create(httpURLResponse: response.response)
                completion?(.failure(HTTPStatusCode.getAPIError()))
                
            case .success(let data):
                guard let data = data
                else {
                    return
                }
                
                do {
                    let searchResult = try JSONDecoder().decode(SearchResultCodable.self, from: data)
                    print("[SUCCESS]", searchResult)
                    completion?(.success(searchResult.items))
                    
                } catch {
                    print("[DECODING ERROR]", error.localizedDescription)
                    completion?(.failure(APIError.unknown))
                }
            }
        }
    }
}

extension RepositoryAPI: ReactiveCompatible {}

// Reactive Programmingを行うための拡張
extension Reactive where Base: RepositoryAPI {
    
    func getRepositories(by searchWord: String) -> Observable<Result<[RepositoryCodable], APIError>> {
        return Observable.create { observer in
            RepositoryAPI.shared.searchRepositories(by: searchWord) { result in
                observer.onNext(result)
            }
            return Disposables.create()
        }.share(replay: 1, scope: .whileConnected)
    }
}
