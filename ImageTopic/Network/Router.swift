//
//  Router.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/14/25.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case getTopicPhotos(id: String, page: Int)
    
    var baseURL: URL {
        guard let url = URL(string: APIInfo.baseURLString) else {
            fatalError("baseURL Error")
        }
        return url
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var paths: String? {
        switch self {
        case .getTopicPhotos(let id, _):
            return "/topics/\(id)/photos"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getTopicPhotos(_, let page):
            return [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "client_id", value: APIInfo.accessKey)
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = try baseURL.asURL()
        if let paths { url = url.appendingPathComponent(paths) }
        url = url.appending(queryItems: queryItems)
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        return urlRequest
    }
}
