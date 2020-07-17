//
//  GithubJobListBuilder.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/17.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs

protocol GithubJobListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class GithubJobListComponent: Component<GithubJobListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol GithubJobListBuildable: Buildable {
    func build(withListener listener: GithubJobListListener) -> GithubJobListRouting
}

final class GithubJobListBuilder: Builder<GithubJobListDependency>, GithubJobListBuildable {

    override init(dependency: GithubJobListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: GithubJobListListener) -> GithubJobListRouting {
        //let component = GithubJobListComponent(dependency: dependency) -> child dependency
        guard let viewController = UIStoryboard(name: "GithubJobListViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "GithubJobListViewController") as? GithubJobListViewController else {
            fatalError("GithubJobListViewController can't load")
        }
        let interactor = GithubJobListInteractor(presenter: viewController, service: .init(config: AppConfiguration()))
        interactor.listener = listener
        return GithubJobListRouter(interactor: interactor, viewController: viewController)
    }
}
