//
//  AuthorRouter.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import Foundation

enum AuthorRouter: APIRequest {
  case getAuthor(id: Int)

  var baseURLString: String {
    return "https://jsonplaceholder.typicode.com"
  }

  var method: HTTPMethod {
    return .get
  }

  var path: String {
    switch self {
    case .getAuthor:
      return "/users/"
    }
  }

  var urlParameters: [Parameter] {
    switch self {
    case .getAuthor(let userId):
      let authorId = Parameter(key: "id", value: String(userId))
      return [authorId]
    }
  }
}
