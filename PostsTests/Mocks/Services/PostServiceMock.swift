//
//  PostServiceMock.swift
//  PostsTests
//
//  Created by Clau Carrillo on 18/03/22.
//

@testable import Posts
import Combine

struct PostServiceMock: PostServiceBase {
  private var posts: [Post] = []
  private var authors: [Author] = []
  private var comments: [Comment] = []

  init(posts: [Post] = [], authors: [Author] = [], comments: [Comment] = []) {
    self.posts = posts
    self.authors = authors
    self.comments = comments
  }

  func getPosts() -> AnyPublisher<[Post], APIError> {
    return Just<[Post]>(posts)
      .setFailureType(to: APIError.self)
      .eraseToAnyPublisher()
  }

  func getAuthor(id: Int) -> AnyPublisher<[Author], APIError> {
    return Just<[Author]>(authors)
      .setFailureType(to: APIError.self)
      .eraseToAnyPublisher()
  }

  func getComments(postId: Int) -> AnyPublisher<[Comment], APIError> {
    let comments = [
      Comment(id: 1, name: "Name 1", email: "name1@user.com", body: "This is my comment user 1."),
      Comment(id: 2, name: "Name 2", email: "name2@user.com", body: "This is my comment user 2."),
      Comment(id: 3, name: "Name 3", email: "name3@user.com", body: "This is my comment user 3.")
    ]

    return Just<[Comment]>(comments)
      .setFailureType(to: APIError.self)
      .eraseToAnyPublisher()
  }
}
