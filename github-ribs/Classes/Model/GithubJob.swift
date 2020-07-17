//
//  GithubJob.swift
//  github-ribs
//
//  Created by HS Lee on 2020/07/17.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation

struct GithubJob: Codable {
    let id, type: String
    let url: String
    let createdAt, company: String
    let companyUrl: String?
    let location, title, jobDescription: String
    let howToApply: String?
    let companyLogo: String?

    enum CodingKeys: String, CodingKey {
        case id, type, url
        case createdAt = "created_at"
        case company
        case companyUrl = "company_url"
        case location, title
        case jobDescription = "description"
        case howToApply = "how_to_apply"
        case companyLogo = "company_logo"
    }
}
