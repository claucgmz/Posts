//
//  Author.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import Foundation

struct Author: Codable, Equatable, Identifiable {
  var id: Int
  let name: String
  let username: String
}

extension Author: Storable {
  static func type() -> DatabaseEntity.Type {
    return AuthorDatabaseEntity.self
  }
  // MARK: Map Storable to DatabaseEntity
  func toDatabaseEntity() -> DatabaseEntity? {
    let entity = AuthorDatabaseEntity()
    entity.id = self.id
    entity.name = self.name
    entity.username = self.username
    return entity
  }
}
