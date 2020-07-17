//
//  GithubJobListViewController.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/17.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol GithubJobListPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class GithubJobListViewController: UIViewController, GithubJobListPresentable, GithubJobListViewControllable {

    @IBOutlet weak var tableView: UITableView!
    weak var listener: GithubJobListPresentableListener?
}
