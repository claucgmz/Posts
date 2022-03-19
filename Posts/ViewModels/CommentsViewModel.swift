//
//  CommentsViewModel.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import SwiftUI
import Combine

class CommentsViewModel: ObservableObject, Identifiable {
  let comments: [Comment]

  var numberOfComments: Int {
    comments.count
  }

  init(comments: [Comment]) {
    self.comments = comments
  }
}
