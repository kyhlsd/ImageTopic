//
//  TopicResult.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/14/25.
//

import Foundation

struct PhotoResult: Decodable {
    let id: String
    // 2025-06-09T12:22:03Z
    let created_at: String
    let width: Int
    let height: Int
    let urls: PhotoUrl
    let likes: Int
    let user: PhotoUser
}

struct PhotoUrl: Decodable {
    let raw: String
    let small: String
}

struct PhotoUser: Decodable {
    let name: String
    let profile_image: ProfileImage
}

struct ProfileImage: Decodable {
    let medium: String
}
