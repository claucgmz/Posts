//
//  URLSession.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import Foundation
import Combine

extension URLSession {
  func performRequest<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, APIError> {
    let publisher = self
      .dataTaskPublisher(for: request)
      .tryMap { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse else {
          throw APIError.noData
        }

        let result = self.handleNetworkResponse(httpResponse)

        switch result {
        case .success:
          return element.data
        case .failure(let error):
          throw error
        }
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .mapError { error in
        return error as? APIError ?? APIError.unknown
      }
      .eraseToAnyPublisher()

    return publisher
  }

  private func handleNetworkResponse(_ response: HTTPURLResponse) -> APIResponse {
    switch response.statusCode {
    case 200...299:
      return .success
    case 501...599:
      return .failure(APIError.badRequest)
    default:
      return .failure(APIError.requestFailed(nil, response.statusCode))
    }
  }
}
