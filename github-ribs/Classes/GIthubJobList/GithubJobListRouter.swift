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
    // TODO: 메서드 선언, 라우터가 보기 계층 조작하는 걸 호출
}


//Router
//Router는 Interactor를 듣고..?(listens) 출력을 하위 RIBs에 연결(attaching) 및 분리(detaching)로 변환합니다.
//Router는 다음과 같은 3가지의 간단한 이유로 존재합니다.
//
//1. Router는 Humble Objects(겸손한 객체...) 의 역할을 하여, 하위 Interactor를 mock하거나
//그 존재에 대해 신경 쓸 필요없이 복잡한 Interactor 로직을 쉽게 테스트 할 수 있습니다.
//Humble Object 는 Humble Object는 테스트 가능한 객체를 감싸는 wrapper로,
//테스트하기 어려운 객체의 로직을 비용면에서 효율적인 방식으로 가져오는 방법입니다.
//
//출처 : http://xunitpatterns.com/Humble%20Object.html
//
//2. Router는 상위 interactor와 하위 interactor간에 추가 추상화 계층을 만듭니다. 이로 인해 interactor간의 동기 통신이 조금 더 어려워지고,
//RIBs간의 직접 연결 대신 reactive communication 채택이 권장됩니다.
//
//3. Router에는 interactor가 구현할 수 있는 단순하고 반복적인 라우팅 로직이 포함되어 있습니다. 이 boilerplate code를 제외하면
//interactor를 작게 유지하고 RIB이 제공하는 핵심 비즈니스 로직에 더 집중 할 수 있습니다.
//
//ref : https://zeddios.tistory.com/937
final class GithubJobListRouter: ViewableRouter<GithubJobListInteractable, GithubJobListViewControllable>, GithubJobListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    // TODO: 생성자는 하위 빌더 프로토콜을 주입하여 자식을 빌드할 수 있도록 한다.
    override init(interactor: GithubJobListInteractable, viewController: GithubJobListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
