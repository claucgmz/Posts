//
//  BaseView.swift
//  Posts
//
//  Created by Clau Carrillo on 16/03/22.
//

import SwiftUI

struct BaseView<Content>: View where Content: View {
  private let content: Content
  private var isLoading: Bool

  public init(isLoading: Bool, @ViewBuilder content: () -> Content) {
    self.isLoading = isLoading
    self.content = content()
  }

  var body: some View {
    ZStack(alignment: .center) {
      content
      if isLoading {
        VStack {
          Spacer()
          ProgressView()
          Spacer()
        }
      }
    }
  }
}
