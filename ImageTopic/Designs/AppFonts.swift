//
//  AppFonts.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/14/25.
//

import UIKit

extension UIFont {
    static let title = UIFont.boldSystemFont(ofSize: 18)
    static let subtitle = UIFont.boldSystemFont(ofSize: 16)
    enum Body {
        static let normal = UIFont.systemFont(ofSize: 14)
        static let bold = UIFont.boldSystemFont(ofSize: 14)
    }
    enum Detail {
        static let normal = UIFont.systemFont(ofSize: 12)
        static let bold = UIFont.boldSystemFont(ofSize: 12)
    }
}
