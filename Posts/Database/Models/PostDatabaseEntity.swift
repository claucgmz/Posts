//
//  PostDatabaseEntity.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import RealmSwift

class PostDatabaseEntity: Object, DatabaseEntity {
  @Persisted(primaryKey: true) var id: Int
  @Persisted var userId: Int
  @Persisted var title: String
  @Persisted var body: String
}

extension PostDatabaseEntity {
  func toModelEntity() -> Storable? {
    return Post(id: self.id, userId: self.userId, title: self.title, body: self.body)
  }
}
