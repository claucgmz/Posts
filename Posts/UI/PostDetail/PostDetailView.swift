//
//  PostDetailView.swift
//  Posts
//
//  Created by Clau Carrillo on 14/03/22.
//

import SwiftUI

struct PostDetailView: View {
  @ObservedObject var viewModel: PostDetailViewModel
  @State var isShowingErrorAlert = false

  // MARK: Initializer
  init(viewModel: PostDetailViewModel) {
    self.viewModel = viewModel
  }

  // MARK: MainView
  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 20) {
        headerView
        bodyView
      }
      CommentsListView.makeView(comments: viewModel.comments)
    }
    .padding()
    .onAppear {
      fetchDetail()
    }
  }

  // MARK: SubViews
  private var headerView: some View {
    VStack(alignment: .leading, spacing: 15) {
      titleView
      if let author = viewModel.author {
        authorView(author)
      }
    }
  }

  private var titleView: some View {
    Text(viewModel.post.title)
      .font(.largeTitle)
      .foregroundColor(.pink)
      .lineSpacing(2)
  }

  private var bodyView: some View {
    Text(viewModel.post.body)
      .font(.body)
      .foregroundColor(.darkGray)
      .multilineTextAlignment(.leading)
  }
  private func authorView(_ author: Author) -> some View {
    Text("\(author.name) - @\(author.username)")
      .font(.callout)
      .foregroundColor(.lightGray)
  }
}

// MARK: Data fetching
extension PostDetailView {
  func fetchDetail() {
    viewModel.fetchDetails()
  }
}
