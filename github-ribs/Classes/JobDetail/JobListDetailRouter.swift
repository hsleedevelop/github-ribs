//
//  JobListDetailRouter.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/20.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs

protocol JobDetailInteractable: Interactable {
    var router: JobDetailRouting? { get set }
    var listener: JobDetailListener? { get set }
}

protocol JobDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class JobDetailRouter: ViewableRouter<JobDetailInteractable, JobDetailViewControllable>, JobDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: JobDetailInteractable, viewController: JobDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
