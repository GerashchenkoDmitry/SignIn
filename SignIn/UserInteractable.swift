//
//  SwiftUIView.swift
//  SignIn
//
//  Created by Дмитрий Геращенко on 10.09.2021.
//

import SwiftUI

struct UserInteractable: ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .foregroundColor(.black)
      .autocapitalization(.none)
      .disableAutocorrection(true)
  }
}


