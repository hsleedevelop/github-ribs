//
//  AppComponent.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/20.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import RIBs

final class AppComponent: Component<EmptyDependency>, RootDependency {
    let service: GithubServiceProtocol
    let appConfiguration: AppConfiguration
    
    init() {
        self.appConfiguration = AppConfiguration()
        self.service = GithubNetworkService(config: appConfiguration)
        
        super.init(dependency: EmptyComponent())
    }
}
