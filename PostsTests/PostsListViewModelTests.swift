//
//  PostsListViewModelTest.swift
//  PostsListViewModelTest
//
//  Created by Clau Carrillo on 18/03/22.
//

import XCTest
import Combine
@testable import Posts

class PostsListViewModelTest: XCTestCase {
  private var cancellables = Set<AnyCancellable>()
  private var posts: CurrentValueSubject<[Post], Never> = .init([])

  // MARK: - Tests
  func testPostListViewModel_FetchPosts() {
    let service = PostServiceMock(posts: [
      Post(id: 1, userId: 1, title: "Title 1", body: "Body 1"),
      Post(id: 2, userId: 2, title: "Title 2", body: "Body 2")
    ])

    let sut = PostsListViewModel(service: service)
    let expectation = XCTestExpectation(description: "Posts should be fetch from service.")
    let expectedCount = 2

    sut.fetchPosts()
    sut.$posts
      .dropFirst()
      .sink { state in
        XCTAssertEqual(state.count, expectedCount)
        expectation.fulfill()
      }
      .store(in: &cancellables)

    wait(for: [expectation], timeout: 3)
  }

  func testPostListViewModel_SavePostsToDatabase() {
    let service = PostServiceMock(posts: [
      Post(id: 1, userId: 1, title: "Title DB 1", body: "Body DB 1"),
      Post(id: 2, userId: 2, title: "Title DB 2", body: "Body DB 2")
    ])

    let database = MockedDatabaseManager()
    let sut = PostsListViewModel(service: service, database: database)
    let expectation = XCTestExpectation(description: "Posts should be saved on database when fetched.")
    let expectedCount = 2

    sut.fetchPosts()
    database.$didSaveObjects
      .dropFirst()
      .sink { _ in
        let posts = sut.loadPostsDB()
        XCTAssertEqual(posts.count, expectedCount)
        expectation.fulfill()
      }
      .store(in: &cancellables)

    wait(for: [expectation], timeout: 3)
  }

  func testPostListViewModel_FetchPostFromDatabase() {
    let service = PostServiceMock(posts: [
      Post(id: 1, userId: 1, title: "Title Fetched from DB 1", body: "Body DB 1")
    ])

    let database = MockedDatabaseManager()
    let sut = PostsListViewModel(service: service, database: database)
    let expectation = XCTestExpectation(description: "Post should be fetched from database.")
    let expectedTitle = "Title Fetched from DB 1"

    sut.fetchPosts()
    database.$didSaveObjects
      .dropFirst()
      .sink { _ in
        let post = database.fetch(Post.self, primaryId: 1) as? Post
        XCTAssertEqual(post?.title, expectedTitle)
        expectation.fulfill()
      }
      .store(in: &cancellables)

    wait(for: [expectation], timeout: 3)
  }
}
