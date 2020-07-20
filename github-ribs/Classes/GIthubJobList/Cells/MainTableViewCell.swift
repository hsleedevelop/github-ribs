//
//  MainTableViewCell.swift
//  github-clean-mvvm
//
//  Created by HS Lee on 2020/07/20.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class MainTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImageView.image = nil
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUIControls()
    }
    
    func setupUIControls() {
        logoImageView.contentMode = .scaleAspectFill
    }
    
    func configure(_ job: GithubJob) {
        self.companyLabel?.text = job.company
        self.jobLabel?.text = job.title
        
        if let url = job.companyLogo {
            ImageNetworkService.shared.get(url)
                .observeOn(MainScheduler.instance)
                .bind(to: logoImageView.rx.image)
                .disposed(by: disposeBag)
        } else {
            logoImageView.image = nil
        }
    }
}
