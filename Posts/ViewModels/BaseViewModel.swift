//
//  BaseViewModel.swift
//  Posts
//
//  Created by Clau Carrillo on 18/03/22.
//

import SwiftUI
import Combine

class BaseViewModel: ObservableObject {
  @Published var isLoadingData = false
  @Published var error: APIError? {
    willSet {
      DispatchQueue.main.async {
        self.errorAlertWillShow.send(true)
      }
    }
  }
  var isFirstTimeLoading = true
  public let errorAlertWillShow = PassthroughSubject<Bool, Never>()
}
