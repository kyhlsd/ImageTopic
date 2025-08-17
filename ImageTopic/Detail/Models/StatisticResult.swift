//
//  StatisticResult.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/15/25.
//

import Foundation

struct StatisticResult: Decodable {
    let id: String
    let downloads: DownloadResult
    let views: ViewResult
}

struct DownloadResult: Decodable {
    let total: Int
    let historical: HistoricalResult
}

struct HistoricalResult: Decodable {
    let values: [ValueResult]
}

struct ValueResult: Decodable {
    // yyyy-MM-dd
    let date: String
    let value: Int
}

struct ViewResult: Decodable {
    let total: Int
    let historical: HistoricalResult
}
