//
//  ImageNetworkService.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/17.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

///이미지 다운로드 제공
final class ImageNetworkService {

    //MARK: * Singleton --------------------
    static let shared = ImageNetworkService()
    
    ///cache
    private let imageCache = NSCache<AnyObject, AnyObject>() //extract?
    
    private init() {
        imageCache.totalCostLimit = 20 * (1024 * 1024) //20 mega bytes
    }

    
    // MARK: - * Main Logic --------------------
    
    func get(_ urlString: String) -> Observable<UIImage> {
        
        guard let url = URL(string: urlString) else {
            return Observable.error(NetworkError.urlGeneration)
        }
        
        return Observable.create { observer in
            var task: URLSessionDataTask?
            
            let cachedImage = self.imageCache.object(forKey: urlString as AnyObject) as? UIImage
            if let image = cachedImage {//캐시에서 읽는 경우,
                observer.onNext(image)
                observer.onCompleted()
            } else {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                }
                task = URLSession.shared.dataTask(with: url) { data, response, error in
                    DispatchQueue.main.async {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                    
                    do {
                        if let data = data, let image = UIImage(data: data) {
                            self.imageCache.setObject(image as AnyObject, forKey: urlString as AnyObject) //캐시에 저장
                            observer.onNext(image)
                        } else {
                            throw NetworkError.errorMessage("no image data")
                        }
                    } catch let error {
                        observer.onError(error)
                    }
                    observer.onCompleted()
                }
            }
            task?.resume()
            
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
