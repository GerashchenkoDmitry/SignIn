//
//  HomePageView.swift
//  SignIn
//
//  Created by Дмитрий Геращенко on 28.09.2021.
//

import SwiftUI

struct HomePageView: View {
  
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
  }
}

struct HomePageView_Previews: PreviewProvider {
  static var previews: some View {
    HomePageView()
  }
}
