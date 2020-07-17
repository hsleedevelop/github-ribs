//
//  GithubJobListInteractor.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/17.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs
import RxSwift

protocol GithubJobListRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol GithubJobListPresentable: Presentable {
    var listener: GithubJobListPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol GithubJobListListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class GithubJobListInteractor: PresentableInteractor<GithubJobListPresentable>, GithubJobListInteractable, GithubJobListPresentableListener {

    weak var router: GithubJobListRouting?
    weak var listener: GithubJobListListener?
    
    private let service: GithubNetworkService

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: GithubJobListPresentable, service: GithubNetworkService) {
        self.service = service
            
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
}
