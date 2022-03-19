//
//  CommentListRow.swift
//  Posts
//
//  Created by Clau Carrillo on 15/03/22.
//

import SwiftUI

struct CommentListRow: View {
  let comment: Comment
  var body: some View {
    VStack(alignment: .leading) {
      Text(comment.name)
        .font(.headline)
      Text(comment.body)
        .font(.body)
        .multilineTextAlignment(.leading)
      Divider()
    }
  }
}
