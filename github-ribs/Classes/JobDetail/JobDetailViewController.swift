//
//  JobDetailViewController.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/20.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import UIKit
import WebKit
import RIBs
import RxSwift

protocol JobDetailPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func didPrepareView()
}

final class JobDetailViewController: UIViewController, JobDetailPresentable, JobDetailViewControllable {

    // MARK: - * Related --------------------
    weak var listener: JobDetailPresentableListener?
    private var observation: NSKeyValueObservation? = nil
    
    // MARK: - * IBOutlets --------------------
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    // MARK: - * Life Cycle --------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearances()
        setupUI()
        listener?.didPrepareView()
    }
    
    private func setupAppearances() {
        view.backgroundColor = .systemBackground
        webView.backgroundColor = .systemBackground
    }
    
    private func setupUI() {
        // add observer to update estimated progress value
        observation = webView.observe(\.estimatedProgress, options: [.new]) { _, _ in
            let progress = Float(self.webView.estimatedProgress)
            self.progressView.progress = progress
            self.progressView.isHidden = progress == 1.0
        }
    }
    
    func loadURL(_ url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
        
    deinit {
        observation = nil
    }
}
