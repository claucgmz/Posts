//
//  PostDetailConfigurator.swift
//  Posts
//
//  Created by Clau Carrillo on 14/03/22.
//

import SwiftUI

extension PostDetailView {
  static func makeView(post: Post) -> some View {
    let database = try? DatabaseManager()
    let viewModel = PostDetailViewModel(post: post, database: database)
    return PostDetailView(viewModel: viewModel)
  }
}
