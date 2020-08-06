//
//  GithubJobListInteractor.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/17.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa

protocol JobListRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    // TODO: 인터렉터가 라우터를 통해 하위 트리를 관리하기 위해 호출할 수 있는 방법을 선언하십시오.
    func routeToDetailJob(_ job: GithubJob)
}

//Presenter(Optional)
//Presenters는 비즈니스 모델을 ViewModel 또는 그 반대로 변환하는 stateless class입니다.
//viewModel변환 테스트를 용이하게 하는데 사용할 수 있습니다.
//그러나 종종 이건 너무 trivial해서 전용 Presenter class를 만들지 않습니다.
//
//Presenter가 생략되면 ViewModel변환은 View(Controller) 또는 Interactor의 책임이 됩니다.
//
//출처: https://zeddios.tistory.com/937
protocol JobListPresentable: Presentable {
    var listener: GithubJobListPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    // TODO: 인터랙터가 프레젠터를 호출하여 데이터를 표시할 수 있는 방법을 선언하십시오.
    //var fetchedItems: Driver<[GithubJob]> { get set }
    var activity: ActivityIndicator { get set }
    var errorTracker: ErrorTracker { get set }

    func showTitle(_ title: String)
    func didFetchItems(items: Driver<[GithubJob]>)
    
}

protocol JobListListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    // TODO: 인터렉터가 다른 RIB와 통신하기 위해 호출할 수 있는 방법을 선언하십시오.
    //func didFetched()
}


//Interactor
//Interactor는 비즈니스 로직을 포함한다고 해요.
//
//Interactor에서
//- Rx subscriptions을 수행
//- 상태 변경 결정을 내림
//- 데이터를 저장할 위치 결정
//- 다른 RIB을 자식으로 붙힐 위치 결정
//을 한다고 해요.
//
//Interactor가 수행하는 모든 작업은 반드시 lifecycle에  국한되어야 합니다.
//Interactor가 활성화 된 경우에만 비즈니스 로직이 실행되도록 툴을 구축했다고 해요.
//
//이렇게하면 Interactor가 비활성화되는 시나리오는 방지되지만 subscriptions이 계속 발생하여
//비즈니스 로직 또는 UI상태에 원치 않는 업데이트가 발생합니다.
//(-> Interactor가 수행하는 모든 작업은 반드시 lifecycle에  국한)
//ref - https://zeddios.tistory.com/937
final class JobListInteractor: PresentableInteractor<JobListPresentable>, GithubJobListInteractable, GithubJobListPresentableListener {
    
    weak var router: JobListRouting?
    weak var listener: JobListListener?
    
    private let service: GithubServiceProtocol

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    // TODO: 생성자에 종속성을 추가하십시오. 생성자에서 논리를 수행하지 마십시오.
    init(presenter: JobListPresentable, service: GithubServiceProtocol) {
        self.service = service
            
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        presenter.showTitle("Job List")
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    func fetchList() {
        let fetchedItems = service.list()
            .trackActivity(presenter.activity)
            .trackError(presenter.errorTracker)
            .asDriver(onErrorJustReturn: [])
        
        presenter.didFetchItems(items: fetchedItems)
    }
    
    func didSelectItem(job: GithubJob) {
        router?.routeToDetailJob(job)
    }
}
