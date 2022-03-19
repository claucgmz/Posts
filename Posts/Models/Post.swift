//
//  Post.swift
//  Posts
//
//  Created by Clau Carrillo on 14/03/22.
//

import Foundation

struct Post: Codable, Equatable, Identifiable {
  var id: Int
  let userId: Int
  let title: String
  let body: String
}

extension Post: Storable {
  static func type() -> DatabaseEntity.Type {
    return PostDatabaseEntity.self
  }
  // MARK: Map Storable to DatabaseEntity
  func toDatabaseEntity() -> DatabaseEntity? {
    let entity = PostDatabaseEntity()
    entity.id = self.id
    entity.userId = self.userId
    entity.title = self.title
    entity.body = self.body
    return entity
  }
}
