//
//  PostsListViewModel.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import SwiftUI
import Combine

class PostsListViewModel: BaseViewModel {
  @Published var posts: [Post] = []

  private let service: PostServiceBase
  private var database: Database?
  private var disposables = Set<AnyCancellable>()

  init(service: PostServiceBase = PostService(), database: Database? = nil) {
    self.service = service
    self.database = database
    super.init()
    loadDataDB()
  }

  // MARK: Fetching Data
  func fetchPosts() {
    isFirstTimeLoading = false
    isLoadingData = true
    service.getPosts()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] completion in
        guard let self = self else { return }
        self.isLoadingData = false
        if case .failure(let error) = completion {
          self.error = error
        }
      }, receiveValue: { [weak self] value in
        guard let self = self else { return }
        self.posts = value
        try? self.saveToDB(posts: value)
      })
      .store(in: &disposables)
  }
}

// MARK: Persistence methods
extension PostsListViewModel {
  private func loadDataDB() {
    self.posts = self.loadPostsDB()
  }

  func loadPostsDB() -> [Post] {
    guard let database = database, let posts = database.fetch(Post.self) as? [Post] else {
      return []
    }

    return posts
  }

  private func saveToDB(posts: [Post]) throws {
    guard let database = database else {
      return
    }
    try database.save(objects: posts)
  }
}
