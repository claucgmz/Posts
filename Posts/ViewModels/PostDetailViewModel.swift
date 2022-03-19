//
//  PostDetailViewModel.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import SwiftUI
import Combine

class PostDetailViewModel: BaseViewModel {
  @Published var author: Author?
  @Published var comments: [Comment] = []

  let post: Post
  private let service: PostServiceBase
  private var database: Database?
  private var disposables = Set<AnyCancellable>()

  init(post: Post, service: PostServiceBase = PostService(), database: Database? = nil) {
    self.post = post
    self.service = service
    self.database = database
  }

  // MARK: Fetch Data
  func fetchDetails() {
    isLoadingData = true
    Publishers.Zip(
      service.getAuthor(id: post.userId),
      service.getComments(postId: post.id)
    )
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] completion in
        guard let self = self else { return }
        self.isLoadingData = false
        if case .failure(let error) = completion {
          self.error = error
        }
      }, receiveValue: { [weak self] author, comments in
        guard let self = self else { return }
        self.author = author.first
        self.comments = comments
      })
      .store(in: &disposables)
  }
}

// MARK: Persistence methods
extension PostDetailViewModel {
  private func loadDataDB() {
    self.author = self.loadAuthorDB()
    self.comments = self.loadCommentsDB()
  }

  private func loadAuthorDB() -> Author? {
    guard let database = database else {
      return nil
    }

    return database.fetch(Author.self, primaryId: post.userId) as? Author
  }

  private func loadCommentsDB() -> [Comment] {
    guard let database = database, let comments = database.fetch(Comment.self) as? [Comment] else {
      return []
    }

    return comments
  }

  private func saveToDB(author: Author) throws {
    guard let database = database else {
      return
    }
    try database.save(object: author)
  }

  private func saveToDB(comments: [Comment]) throws {
    guard let database = database else {
      return
    }
    try database.save(objects: comments)
  }
}
