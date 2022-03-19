//
//  AuthorDatabaseEntity.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import RealmSwift

class AuthorDatabaseEntity: Object, DatabaseEntity {
  @Persisted(primaryKey: true) var id: Int
  @Persisted var name: String
  @Persisted var username: String
}

extension AuthorDatabaseEntity {
  func toModelEntity() -> Storable? {
    return Author(id: self.id, name: self.name, username: self.username)
  }
}
