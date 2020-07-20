//
//  JobListDetailBuilder.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/20.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs

protocol JobListDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class JobListDetailComponent: Component<JobListDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol JobListDetailBuildable: Buildable {
    func build(withListener listener: JobListDetailListener) -> JobListDetailRouting
}

final class JobListDetailBuilder: Builder<JobListDetailDependency>, JobListDetailBuildable {

    override init(dependency: JobListDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: JobListDetailListener) -> JobListDetailRouting {
        let component = JobListDetailComponent(dependency: dependency)
        let viewController = JobListDetailViewController()
        let interactor = JobListDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return JobListDetailRouter(interactor: interactor, viewController: viewController)
    }
}
