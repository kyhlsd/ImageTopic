//
//  APIError.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/20/25.
//

import Foundation

enum APIError: Int, LocalizedError {
    case badRequest = 400
    case unAuthorized = 401
    case forbidden = 403
    case notFound = 404
    case unknown = 500
    
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "잘못된 요청입니다."
        case .unAuthorized:
            return "유효하지 않은 토큰입니다."
        case .forbidden:
            return "권한이 없습니다."
        case .notFound:
            return "존재하지 않는 요청입니다."
        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}
