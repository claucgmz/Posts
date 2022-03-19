//
//  CommentsListView.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import SwiftUI

struct CommentsListView: View {
  var viewModel: CommentsViewModel

  // MARK: Initializer
  init(viewModel: CommentsViewModel) {
    self.viewModel = viewModel
  }

  // MARK: MainViews
  var body: some View {
    Group {
      headerView
      LazyVStack(spacing: 15) {
        ForEach(viewModel.comments) { comment in
          CommentListRow(comment: comment)
        }
      }
      .padding(.horizontal, 10)
    }
  }

  // MARK: SubViews
  private var headerView: some View {
    VStack(spacing: 20) {
      HStack(alignment: .center, spacing: 15) {
        Image.comment
          .resizable()
          .frame(width: 25, height: 25, alignment: .center)
        Text("\(viewModel.numberOfComments) Comments")
          .font(.headline)
          .foregroundColor(.darkGray)
        Spacer()
      }
      Divider()
    }
    .padding(.vertical, 20)
  }
}
