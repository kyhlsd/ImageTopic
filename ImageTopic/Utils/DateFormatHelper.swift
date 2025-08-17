//
//  DateFormatHelper.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/17/25.
//

import Foundation

enum DateFormatHelper {
    static let timeDashFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter
    }()
    
    static let yyyyMdFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
    }()
    
    static func convertFormat(_ dateString: String, from firstFormatter: DateFormatter, to secondFormatter: DateFormatter) -> String {
        if let date = firstFormatter.date(from: dateString) {
            return secondFormatter.string(from: date)
        } else {
            return "wrong format"
        }
    }
}
