//
//  GithubJobListRouter.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/17.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs

protocol GithubJobListInteractable: Interactable {
    var router: GithubJobListRouting? { get set }
    var listener: GithubJobListListener? { get set }
}

protocol GithubJobListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class GithubJobListRouter: ViewableRouter<GithubJobListInteractable, GithubJobListViewControllable>, GithubJobListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: GithubJobListInteractable, viewController: GithubJobListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
