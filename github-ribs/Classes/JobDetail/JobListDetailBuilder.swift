//
//  JobListDetailBuilder.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/20.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs

protocol JobDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var service: GithubServiceProtocol { get }
}

final class JobDetailComponent: Component<JobDetailDependency> {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    var service: GithubServiceProtocol {
        return dependency.service
    }
}

// MARK: - Builder

protocol JobListDetailBuildable: Buildable {
    func build(withListener listener: JobListDetailListener, job: GithubJob) -> JobListDetailRouting
}

final class JobDetailBuilder: Builder<JobDetailDependency>, JobListDetailBuildable {

    override init(dependency: JobDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: JobListDetailListener, job: GithubJob) -> JobListDetailRouting {
        let component = JobDetailComponent(dependency: dependency)
        let viewController = JobListDetailViewController()
        let interactor = JobListDetailInteractor(presenter: viewController, job: job)
        interactor.listener = listener
        
        return JobListDetailRouter(interactor: interactor, viewController: viewController)
    }
}
