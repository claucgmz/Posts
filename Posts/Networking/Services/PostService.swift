//
//  PostService.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import Combine

protocol PostServiceBase: APIService {
  func getPosts() -> AnyPublisher<[Post], APIError>
  func getAuthor(id: Int) -> AnyPublisher<[Author], APIError>
  func getComments(postId: Int) -> AnyPublisher<[Comment], APIError>
}

struct PostService: PostServiceBase {
  func getPosts() -> AnyPublisher<[Post], APIError> {
    return request(PostsRouter.getPosts)
  }

  func getAuthor(id: Int) -> AnyPublisher<[Author], APIError> {
    return request(AuthorRouter.getAuthor(id: id))
  }

  func getComments(postId: Int) -> AnyPublisher<[Comment], APIError> {
    return request(PostsRouter.getComments(postId: postId))
  }
}
