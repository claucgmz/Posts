//
//  DatabaseMock.swift
//  PostsTests
//
//  Created by Clau Carrillo on 18/03/22.
//

@testable import Posts
import Foundation

class MockedDatabaseManager: Database {
  @Published var didSaveObjects = false
  var didSaveObject = false
  var storedObjects: [Storable] = []

  func save(object: Storable) throws {
    didSaveObject = true
  }

  func save(objects: [Storable]) throws {
    storedObjects = objects
    didSaveObjects = true
  }

  func fetch(_ type: Storable.Type) -> [Storable] {
    return storedObjects
  }

  func fetch(_ type: Storable.Type, primaryId: Int) -> Storable? {
    return storedObjects.first { primaryId == $0.id }
  }
}
