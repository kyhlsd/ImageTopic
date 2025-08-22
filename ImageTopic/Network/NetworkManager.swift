//
//  NetworkManager.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/14/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func callRequest<T: Decodable>(url: URLRequestConvertible, type: T.Type = T.self, completionHandler: @escaping (Result<T, Error>) -> Void) {
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: type) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(.success(value))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? -1
                    let error = APIError(rawValue: statusCode) ?? .unknown
                    completionHandler(.failure(error))
                }
            }
    }
}
