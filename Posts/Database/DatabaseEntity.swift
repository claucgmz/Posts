//
//  DatabaseEntity.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import RealmSwift

protocol DatabaseEntity: Object {
  func toModelEntity() -> Storable?
}

extension DatabaseEntity {
  func toModelEntity() -> Storable? {
    fatalError("Need to implement method.")
  }
}

protocol Storable {
  var id: Int { get set }
  static func type() -> DatabaseEntity.Type
  func toDatabaseEntity() -> DatabaseEntity?
}
