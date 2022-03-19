//
//  ListPostsView.swift
//  Posts
//
//  Created by Clau Carrillo on 14/03/22.
//

import SwiftUI

struct PostsListView: View {
  @ObservedObject var viewModel: PostsListViewModel
  @State var isShowingErrorAlert = false
  // MARK: Initializer
  init(viewModel: PostsListViewModel) {
    self.viewModel = viewModel
  }
  // MARK: MainViews
  var body: some View {
    if #available(iOS 15.0, *) {
      mainView
        .refreshable {
          fetchPosts()
        }
    } else {
      mainView
    }
  }

  private var mainView: some View {
    BaseView(isLoading: viewModel.isLoadingData) {
      NavigationView {
        configureView()
          .onReceive(viewModel.errorAlertWillShow) { newValue in
            DispatchQueue.main.async {
              isShowingErrorAlert = newValue
            }
          }
          .onAppear {
            if viewModel.isFirstTimeLoading {
              fetchPosts()
            }
          }
          .alert(isPresented: $isShowingErrorAlert) {
            Alert.makeAlert(withError: viewModel.error)
          }
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
            ToolbarItem(placement: .principal) {
              toolbarView
            }
          }
      }
      .accentColor(.darkGray)
    }
  }
  // MARK: SubViews
  private func configureView() -> some View {
    if !viewModel.posts.isEmpty {
      return AnyView(postsListView)
    } else {
      return AnyView(emptyView)
    }
  }
  private var emptyView: some View {
    List {
      HStack {
        Spacer()
        noPostsView
        Spacer()
      }
      .listRowBackground(Color.clear)
    }
  }
  private var noPostsView: some View {
    VStack(alignment: .center) {
      Text("No posts")
        .font(.largeTitle)
        .foregroundColor(.darkGray)
      Image.plane
        .resizable()
        .frame(width: 30, height: 30, alignment: .center)
    }
  }
  private var postsListView: some View {
    List {
      ForEach(viewModel.posts) { post in
        NavigationLink(destination: PostDetailView.makeView(post: post)) {
          PostsListRow(post: post)
        }
      }
    }
  }
  private var toolbarView: some View {
    VStack {
      Text("Posts").font(.headline)
    }
  }
}

// MARK: Data fetching
extension PostsListView {
  func fetchPosts() {
    viewModel.fetchPosts()
  }
}
