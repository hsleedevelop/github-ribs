//
//  GithubJobListViewController.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/17.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import UIKit
import RIBs
import RxSwift
import RxCocoa

protocol GithubJobListPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    // TODO: signIn()과 같은 비즈니스 로직을 수행하기 위해 뷰 컨트롤러가 호출할 수 있는 속성 및 메서드를 선언하십시오.
    // 이 프로토콜은 해당 인터랙터 클래스에 의해 구현된다.
    
    func fetchList()
}


//View(Controller)(Optional)
//- View는 UI를 빌드하고 업데이트합니다.
//여기에는
//- UI 구성요소 인스턴스화 및 레이아웃
//- 사용자 상호작용 처리
//- UI 구성 요소에 데이터 채우기 및 애니메이션
//이 포함됩니다.
//View는 가능한 말이없는(dumb)것으로 설계되었습니다.
//단지 정보를 표시 할 뿐입니다. 일반적으로 Unit Test가 필요한 코드는 포함되어 있지 않습니다.
//출처; https://zeddios.tistory.com/937
final class GithubJobListViewController: UIViewController, GithubJobListPresentable, GithubJobListViewControllable, Alertable {

    // MARK: - * Related --------------------
    weak var listener: GithubJobListPresentableListener?
    
    // MARK: - * Properties --------------------
    private var incompleteJobs: [GithubJob] = []
    private var disposeBag = DisposeBag()
    
    var activity = ActivityIndicator()
    var errorTracker = ErrorTracker()
    
    // MARK: - * IBOutlets --------------------
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - * Life Cycle --------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupRx()
        
        listener?.fetchList()
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupRx() {
        activity
            .map { !$0 }
            .drive(activityIndicatorView.rx.isHidden)
            .disposed(by: disposeBag)
        
        errorTracker
            .drive(onNext: { [weak self] error in
                guard let self = self else { return }
                self.showAlert(message: error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}

extension GithubJobListViewController {
    
    func didFetchItems(items: Driver<[GithubJob]>) {
        items.drive(tableView.rx.items) { (tv, row, job) -> UITableViewCell in
            guard let cell = tv.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: .init(row: row, section: 0)) as? MainTableViewCell else {
                fatalError("MainTableViewCell not found.")
            }
            cell.configure(job)
            return cell
        }
        .disposed(by: disposeBag)
    }
    
    func showTitle(_ title: String) {
        self.title = title
    }
}
