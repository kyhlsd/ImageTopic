//
//  Router.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/14/25.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case getTopicPhotos(topic: Topic, page: Int)
    case getStatistics(id: String)
    case getSearched(keyword: String, page: Int, perPage: Int, orderBy: OrderBy, color: ColorCategory?)
    
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
        case .getTopicPhotos(let topic, _):
            return "/topics/\(topic.rawValue)/photos"
        case .getStatistics(let id):
            return "/photos/\(id)/statistics"
        case .getSearched(_, _, _, _, _):
            return "/search/photos"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getTopicPhotos(_, let page):
            return [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "client_id", value: APIInfo.accessKey)
            ]
        case .getStatistics(_):
            return [
                URLQueryItem(name: "client_id", value: APIInfo.accessKey)
            ]
        case .getSearched(let keyword, let page, let perPage, let orderBy, color: let color):
            var items = [
                URLQueryItem(name: "query", value: keyword),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "per_page", value: String(perPage)),
                URLQueryItem(name: "order_by", value: orderBy.rawValue)
            ]
            if let color {
                items.append(URLQueryItem(name: "color", value: color.rawValue))
            }
            items.append(URLQueryItem(name: "client_id", value: APIInfo.accessKey))
            return items
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
