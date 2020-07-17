//
//  AppConfiguration.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 25.02.19.
//

import Foundation

final class AppConfiguration {
    lazy var apiBaseURL: String = {
        return "https://jobs.github.com"
    }()
}
