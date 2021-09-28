//
//  SignInApp.swift
//  SignIn
//
//  Created by Дмитрий Геращенко on 30.08.2021.
//

import SwiftUI

@main
struct SignInApp: App {
  
  @StateObject var userAuth = UserAuth()
  
  var body: some Scene {
    WindowGroup {
      if userAuth.isLoggedIn {
        ContentView()
          .environmentObject(userAuth)
        
      } else {
        LoginView()
          .environmentObject(userAuth)
        
      }
    }
  }
}
