//
//  Requestable.swift
//  Posts
//
//  Created by Clau Carrillo on 14/03/22.
//

import Combine
import Foundation

protocol APIService {
  func request<T: Decodable>(_ request: APIRequest) -> AnyPublisher<T, APIError>
}

extension APIService {
  func request<T: Decodable>(_ request: APIRequest) -> AnyPublisher<T, APIError> {
    guard let urlRequest = try? request.asURLRequest() else {
      return Fail(error: APIError.badRequest).eraseToAnyPublisher()
    }

    return URLSession.shared
      .performRequest(urlRequest)
  }
}
