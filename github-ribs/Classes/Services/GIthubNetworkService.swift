//
//  GIthubNetworkService.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/17.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import RxSwift

protocol GithubServiceProtocol: class {
    func list() -> Observable<[GithubJob]>
}

final class GithubNetworkService: NetworkService, GithubServiceProtocol {
    typealias T = GithubAPI
    var baseURL: String

    init(config: AppConfiguration) {
        self.baseURL = config.apiBaseURL
    }
    
    func list() -> Observable<[GithubJob]> {
        return request(baseURL: self.baseURL, api: .list(0, 0))
            .map([GithubJob].self)
    }
}
