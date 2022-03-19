//
//  PostsListView+Maker.swift
//  Posts
//
//  Created by Clau Carrillo on 14/03/22.
//

import SwiftUI

extension PostsListView {
  static func makeView() -> some View {
    let database = try? DatabaseManager()
    let viewModel = PostsListViewModel(database: database)
    return PostsListView(viewModel: viewModel)
  }
}
