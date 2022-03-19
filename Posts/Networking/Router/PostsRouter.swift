//
//  PostsRouter.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import Foundation

enum PostsRouter: APIRequest {
  case getPosts
  case getComments(postId: Int)

  var baseURLString: String {
    return "https://jsonplaceholder.typicode.com"
  }

  var method: HTTPMethod {
    return .get
  }
  var path: String {
    switch self {
    case .getPosts:
      return "/posts/"
    case .getComments:
      return "/comments/"
    }
  }
  var urlParameters: [Parameter] {
    switch self {
    case .getComments(let postId):
      let postId = Parameter(key: "postId", value: String(postId))
      return [postId]
    default:
      return []
    }
  }
}
