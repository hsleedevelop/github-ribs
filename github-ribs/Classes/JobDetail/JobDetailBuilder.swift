//
//  JobDetailBuilder.swift
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

protocol JobDetailBuildable: Buildable {
    func build(withListener listener: JobDetailListener, job: GithubJob) -> JobDetailRouting
}

final class JobDetailBuilder: Builder<JobDetailDependency>, JobDetailBuildable {

    override init(dependency: JobDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: JobDetailListener, job: GithubJob) -> JobDetailRouting {
        guard let viewController = UIStoryboard(name: "JobDetailViewController", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "JobDetailViewController") as? JobDetailViewController else {
                fatalError("JobDetailViewController can't load")
        }
        
        let component = JobDetailComponent(dependency: dependency)
        let interactor = JobDetailInteractor(presenter: viewController, job: job)
        interactor.listener = listener
        
        return JobDetailRouter(interactor: interactor, viewController: viewController)
    }
}
