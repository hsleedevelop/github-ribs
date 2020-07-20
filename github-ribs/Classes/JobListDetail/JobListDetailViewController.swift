//
//  JobListDetailViewController.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/20.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol JobListDetailPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class JobListDetailViewController: UIViewController, JobListDetailPresentable, JobListDetailViewControllable {

    weak var listener: JobListDetailPresentableListener?
}
