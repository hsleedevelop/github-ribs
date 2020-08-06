//
//  JobListBuilder.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/17.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs
import RxSwift

protocol JobListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    //이 RIB에 필요한 종속성 집합을 선언하지만 이 RIB에서 생성할 수 없음.
    var service: GithubServiceProtocol { get }
}

//Component
//Component는 RIB종속성을 관리하는데 사용됩니다.
//
//RIB을 구성하는 다른 Unit을 인스턴스화하여 Builder를 지원합니다. Component는
//
//- RIB을 구축하는데 필요한 외부 종속성에 대한 액세스를 제공
//- RIB자체에서 생성된 종속성을 소유
//- 다른 RIB에서 위에 대한 액세스 제어
//
//를 한다고 합니다. 부모 RIB의 Component는 일반적으로 자식 RIB의 Builder에 주입되어
//자식에서 부모 RIB의 종속성에 대한 액세스 권한을 부여합니다.
//
//출처: https://zeddios.tistory.com/937
final class JobListComponent: Component<JobListDependency>, JobDetailDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    // 이 RIB에서만 사용되는 'fileprivate' 종속성을 선언하십시오
    var service: GithubServiceProtocol {
        return dependency.service
    }
}

// MARK: - Builder

protocol JobListBuildable: Buildable {
    func build(withListener listener: JobListListener) -> JobListRouting
}


//Builder
//Builder의 책임은 RIB의 각 구성요소 클래스/children을 위한 Builder를 인스턴스화 하는 것입니다.
//
//Builder에서 클래스 작성 로직을 분리하면 iOS에서 mockability에 대한 지원이 추가되고,
//나머지 RIB코드는 DI구현의 세부사항에 영향을 미치지 않습니다.
//
//Builder는 프로젝트에서 사용된 DI 시스템을 인식해야하는 RIB의 유일한 부분입니다.
//다른 Builder를 구현하면 다른 DI 메커니즘을 사용하여 프로젝트에서 나머지 RIB코드를 재사용 할 수 있습니다.
//
//출처: https://zeddios.tistory.com/937
//
final class JobListBuilder: Builder<JobListDependency>, JobListBuildable {

    override init(dependency: JobListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: JobListListener) -> JobListRouting {
        guard let viewController = UIStoryboard(name: "JobListViewController", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "JobListViewController") as? JobListViewController else {
                fatalError("JobListViewController can't load")
        }
        let component = JobListComponent(dependency: dependency) //-> child dependency
        let interactor = JobListInteractor(presenter: viewController, service: component.service)
        interactor.listener = listener
        
        let detailBuilder = JobDetailBuilder(dependency: component)
        let router = JobListRouter(interactor: interactor, viewController: viewController, detailBuilder: detailBuilder)
        return router
    }
}
