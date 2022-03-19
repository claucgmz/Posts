//
//  APIRequest.swift
//  Posts
//
//  Created by Clau Carrillo on 14/03/22.
//

import Foundation

protocol APIRequest {
  var baseURLString: String { get }
  var method: HTTPMethod { get }
  var path: String { get }
  var bodyParameters: [Parameter] { get }
  var urlParameters: [Parameter] { get }
  var headerParameters: [Parameter] { get }
  func asURLRequest() throws -> URLRequest?
}

extension APIRequest {
  var bodyParameters: [Parameter] { [] }
  var urlParameters: [Parameter] { [] }
  var headerParameters: [Parameter] { [] }

  func asURLRequest() throws -> URLRequest? {
    let request = self

    guard let baseURL = URL(string: request.baseURLString) else {
      return nil
    }

    let url = baseURL.appendingPathComponent(request.path)
    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
    if !request.urlParameters.isEmpty {
      components?.queryItems = request.urlParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    guard let url = components?.url else {
      return nil
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    request.headerParameters.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
    return urlRequest
  }
}
