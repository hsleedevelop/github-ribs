//
//  RootBuilder.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/17.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    // 이 RIB에 필요한 종속성 집합을 선언하지만 이 RIB에서 생성할 수 없음.
    var service: GithubServiceProtocol { get }
}

final class RootComponent: Component<RootDependency>, GithubJobListDependency {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    // 이 RIB에서만 사용되는 'fileprivate' 종속성을 선언하십시오
    var service: GithubServiceProtocol {
        dependency.service
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        let jobListBuilder = GithubJobListBuilder(dependency: component)
        return RootRouter(interactor: interactor, viewController: viewController, jobListBuilder: jobListBuilder)
    }
}
