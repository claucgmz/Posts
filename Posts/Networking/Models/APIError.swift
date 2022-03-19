//
//  APIError.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import Foundation

enum APIError: Error, LocalizedError, Identifiable {
  var id: String { localizedDescription }
  // MARK: Expected errors
  case requestFailed(Error?, Int)
  case badRequest
  case noData
  case unknown

  var localizedDescription: String {
    switch self {
    case let .requestFailed(error, code):
      return "Status code: \(code) | Error: \(error?.localizedDescription ?? "unknown")]"
    case .noData:
      return "NoData"
    default:
      return "Something went wrong!"
    }
  }
}
