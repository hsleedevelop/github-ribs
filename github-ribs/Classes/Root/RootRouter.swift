//
//  RootRouter.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/17.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, JobListListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    private let jobListBuilder: JobListBuildable
    
    init(interactor: RootInteractable, viewController: RootViewControllable, jobListBuilder: JobListBuildable) {
        self.jobListBuilder = jobListBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func buildList() {
        let jobList = jobListBuilder.build(withListener: interactor)
        attachChild(jobList)
        viewController.present(viewController: jobList.viewControllable)
    }
    
    override func didLoad() {
        super.didLoad()
        
        buildList()
    }
}
