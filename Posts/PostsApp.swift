//
//  PostsApp.swift
//  Posts
//
//  Created by Clau Carrillo on 14/03/22.
//

import SwiftUI

@main
struct PostsApp: App {
  var body: some Scene {
    WindowGroup {
      ZStack {
        PostsListView.makeView()
      }
    }
  }
}
