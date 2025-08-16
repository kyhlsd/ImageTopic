//
//  ColorCategory.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/16/25.
//

import UIKit

enum ColorCategory: String, CaseIterable {
    case black
    case white
    case yellow
    case red
    case purple
    case green
    case blue
    
    var description: String {
        switch self {
        case .black: return "블랙"
        case .white: return "화이트"
        case .yellow: return "옐로우"
        case .red: return "레드"
        case .purple: return "퍼플"
        case .green: return "그린"
        case .blue: return "블루"
        }
    }
}
