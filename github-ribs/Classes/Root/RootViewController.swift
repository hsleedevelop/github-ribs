//
//  RootViewController.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/17.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    
    func present(viewController: ViewControllable) {
        let navigationViewController = UINavigationController(rootViewController: viewController.uiviewController)
        navigationViewController.modalPresentationStyle = .fullScreen
        self.present(navigationViewController, animated: false, completion: nil)
    }

    weak var listener: RootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("root view loaded")
        setupAppearances()
    }
    
    func setupAppearances() {
        view.backgroundColor = .white
    }
}
