//
//  DatabaseManager.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import RealmSwift

class DatabaseManager: Database {
  var realm: Realm

  init() throws {
    do {
      realm = try Realm()
    } catch let error {
      throw error
    }
  }

  func save(object: Storable) throws {
    guard let databaseObject = object.toDatabaseEntity() else {
      return
    }

    try realm.write {
      realm.add(databaseObject, update: .modified)
    }
  }

  func save(objects: [Storable]) throws {
    try objects.forEach { object in
      try save(object: object)
    }
  }

  func fetch(_ type: Storable.Type) -> [Storable] {
    let objectType = type.type()
    let objects = realm.objects(objectType)
    return objects.compactMap { ($0 as? DatabaseEntity)?.toModelEntity() }
  }

  func fetch(_ type: Storable.Type, primaryId: Int) -> Storable? {
    let objectType = type.type()
    guard let object = realm.object(ofType: objectType, forPrimaryKey: primaryId) as? DatabaseEntity else {
      return nil
    }

    return object.toModelEntity()
  }
}
