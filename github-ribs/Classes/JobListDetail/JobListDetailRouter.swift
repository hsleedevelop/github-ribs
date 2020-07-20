//
//  JobListDetailRouter.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/20.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs

protocol JobListDetailInteractable: Interactable {
    var router: JobListDetailRouting? { get set }
    var listener: JobListDetailListener? { get set }
}

protocol JobListDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class JobListDetailRouter: ViewableRouter<JobListDetailInteractable, JobListDetailViewControllable>, JobListDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: JobListDetailInteractable, viewController: JobListDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
