//
//  Authentification.swift
//  SignIn
//
//  Created by Дмитрий Геращенко on 28.09.2021.
//

import Combine

class UserAuth: ObservableObject {
  
  @Published var isLoggedIn = false
  
  func login() {
    // login request... on success:
    self.isLoggedIn = true
  }
  
  func logout() {
    self.isLoggedIn = false
  }
  
}

