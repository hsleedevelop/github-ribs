//
//  JobDetailInteractor.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/20.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs
import RxSwift

protocol JobDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol JobDetailPresentable: Presentable {
    var listener: JobDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func loadURL(_ url: URL)
}

protocol JobDetailListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class JobDetailInteractor: PresentableInteractor<JobDetailPresentable>, JobDetailInteractable, JobDetailPresentableListener {

    weak var router: JobDetailRouting?
    weak var listener: JobDetailListener?
    
    private let job: GithubJob

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: JobDetailPresentable, job: GithubJob) {
        self.job = job
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didPrepareView() {
        if let url = URL(string: job.companyUrl ?? job.companyLogo ?? "") {
            presenter.loadURL(url)
        }
    }
}
