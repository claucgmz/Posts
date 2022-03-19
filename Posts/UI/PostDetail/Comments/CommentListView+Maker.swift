//
//  CommentListView+Maker.swift
//  Posts
//
//  Created by Clau Carrillo on 16/03/22.
//

import SwiftUI

extension CommentsListView {
  static func makeView(comments: [Comment]) -> some View {
    let viewModel = CommentsViewModel(comments: comments)
    return CommentsListView(viewModel: viewModel)
  }
}
