//
//  SearchedResult.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/16/25.
//

import Foundation

struct SearchedResult: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}
