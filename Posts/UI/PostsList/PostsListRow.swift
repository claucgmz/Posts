//
//  PostsListRow.swift
//  Posts
//
//  Created by Clau Carrillo on 14/03/22.
//

import SwiftUI

struct PostsListRow: View {
  let post: Post

  // MARK: MainView
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      titleView
      bodyView
    }
    .padding(.vertical, 20)
    .padding(.horizontal, 15)
  }

  // MARK: SubViews
  private var titleView: some View {
    Text(post.title)
      .font(.headline)
      .foregroundColor(.pink)
      .lineSpacing(2)
  }
  private var bodyView: some View {
    Text(post.body)
      .font(.subheadline)
      .foregroundColor(.darkGray)
      .multilineTextAlignment(.leading)
      .lineLimit(5)
  }
}
