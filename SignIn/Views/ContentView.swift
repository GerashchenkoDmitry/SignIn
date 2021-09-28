//
//  ContentView.swift
//  SignIn
//
//  Created by Дмитрий Геращенко on 30.08.2021.
//

import SwiftUI
import Combine

struct ContentView: View {
  
  @EnvironmentObject var userAuth: UserAuth
  
  var body: some View {
    NavigationView {
      VStack {
        Text("Signed In View")
      }
      .navigationTitle("Signed In")
      .toolbar{
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Log out") {
            userAuth.logout()
          }
        }
      }
    }
    .transition(.slide)
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
