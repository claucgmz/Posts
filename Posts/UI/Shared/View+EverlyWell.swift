//
//  View+EverlyWell.swift
//  Posts
//
//  Created by Clau Carrillo on 17/03/22.
//

import SwiftUI

extension View {
  func round(backgroundColor: Color, cornerRadius: CGFloat = 10) -> some View {
    self
      .background(backgroundColor)
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
  }

  @ViewBuilder func `if`<T: View>(_ conditional: Bool, transform: (Self) -> T) -> some View {
    if conditional {
      transform(self)
    } else {
      self
    }
  }
}
