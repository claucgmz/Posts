//
//  DatabaseManagerBase.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import Foundation

protocol Database {
  func save(object: Storable) throws
  func save(objects: [Storable]) throws
  func fetch(_ type: Storable.Type) -> [Storable]
  func fetch(_ type: Storable.Type, primaryId: Int) -> Storable?
}
