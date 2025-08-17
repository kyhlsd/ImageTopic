//
//  UserDefaultManager.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/17/25.
//

import Foundation

enum UserDefaultManager {
    enum Favorites {
        @UserDefault(key: "Favorites", defaultValue: [])
        static var list: [String]
        
        static func getFavoriteImage(_ id: String) -> String {
            return list.contains(id) ? "heart.fill" : "heart"
        }
        
        static func toggleItemInMovieBox(_ id: String) {
            if let index = list.firstIndex(of: id) {
                list.remove(at: index)
            } else {
                list.append(id)
            }
        }
    }
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
