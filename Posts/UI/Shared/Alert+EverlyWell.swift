//
//  Alert+EverlyWell.swift
//  Posts
//
//  Created by Clau Carrillo on 18/03/22.
//

import SwiftUI

extension Alert {
  static func makeAlert(withError error: Error?) -> Alert {
    let descriptionText = error?.localizedDescription ?? "Something went wrong!"
    return Alert(title: Text("Error"), message: Text(descriptionText), dismissButton: .default(Text("OK")))
  }
}
