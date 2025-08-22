//
//  StatisticResult.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/15/25.
//

import Foundation

struct StatisticResult: Decodable {
    let id: String
    let downloads: StatisticSubResult
    let views: StatisticSubResult
}

struct StatisticSubResult: Decodable {
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

enum ChartSegmented: String, CaseIterable {
    case views = "조회"
    case downloads = "다운로드"
}
