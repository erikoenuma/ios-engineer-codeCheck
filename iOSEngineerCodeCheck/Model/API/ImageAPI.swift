//
//  ImageAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2022/01/23.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import RxSwift
import UIKit

final class ImageAPI {
    
    private init() {}
    static let shared = ImageAPI()
    
    func getImage(url: URL, completion: ((Result<UIImage, Error>) -> Void)?) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion?(.failure(error))
            }
            
            guard let data = data,
                  let image = UIImage(data: data)
            else {
                return
            }
            completion?(.success(image))
        }
        task.resume()
    }
}

extension ImageAPI: ReactiveCompatible {}

// Reactive Programmingを行うための拡張
extension Reactive where Base: ImageAPI {
    
    func getImage(url: URL) -> Observable<Result<UIImage, Error>> {
        return Observable.create { observer in
            ImageAPI.shared.getImage(url: url) { result in
                observer.onNext(result)
            }
            return Disposables.create()
        }.share(replay: 1, scope: .whileConnected)
    }
}
