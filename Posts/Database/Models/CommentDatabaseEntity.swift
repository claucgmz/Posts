//
//  CommentDatabaseEntity.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import RealmSwift

class CommentDatabaseEntity: Object, DatabaseEntity {
  @Persisted(primaryKey: true) var id: Int
  @Persisted var name: String
  @Persisted var email: String
  @Persisted var body: String
}

extension CommentDatabaseEntity {
  func toModelEntity() -> Storable? {
    return Comment(id: self.id, name: self.name, email: self.email, body: self.body)
  }
}
