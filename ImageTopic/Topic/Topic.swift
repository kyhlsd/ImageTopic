//
//  TopicCategory.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/14/25.
//

import Foundation

enum Topic: String, CaseIterable {
    case goldenHour = "golden-hour"
    case businessWork = "business-work"
    case architectureInterior = "architecture-interior"
    case wallPapers
    case nature
    case renders = "3D-renders"
    case travel
    case texturesPatterns = "textures-patterns"
    case streetPhotography = "street-photography"
    case film
    case archival
    case experimental
    case animals
    case fashionBeauty = "fashion-beauty"
    case people
    case foodDrink = "food-drink"
    
    var description: String {
        switch self {
        case .goldenHour: return "골든 아워"
        case .businessWork: return "비즈니스 및 업무"
        case .architectureInterior: return "건축 및 인테리어"
        case .wallPapers: return "배경 화면"
        case .nature: return "자연"
        case .renders: return "3D 렌더링"
        case .travel: return "여행하다"
        case .texturesPatterns: return "텍스쳐 및 패턴"
        case .streetPhotography: return "거리 사진"
        case .film: return "필름"
        case .archival: return "기록의"
        case .experimental: return "실험적인"
        case .animals: return "동물"
        case .fashionBeauty: return "패션 및 뷰티"
        case .people: return "사람"
        case .foodDrink: return "식음료"
        }
    }
}
