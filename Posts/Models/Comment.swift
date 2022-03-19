//
//  Comment.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import Foundation

struct Comment: Codable, Equatable, Identifiable {
  var id: Int
  let name: String
  let email: String
  let body: String
}

extension Comment: Storable {
  static func type() -> DatabaseEntity.Type {
    return CommentDatabaseEntity.self
  }
  // MARK: Map Storable to DatabaseEntity
  func toDatabaseEntity() -> DatabaseEntity? {
    let entity = CommentDatabaseEntity()
    entity.id = self.id
    entity.name = self.name
    entity.email = self.email
    entity.body = self.body
    return entity
  }
}
