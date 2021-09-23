//
//  PasswordView.swift
//  SignIn
//
//  Created by Дмитрий Геращенко on 08.09.2021.
//

import SwiftUI

struct PasswordView: View {
  
  @Binding var text: String
  @Binding var secured: Bool
  
  var imageName: String
  var captionText: String
  
  var body: some View {
    GeometryReader { geo in
      HStack {
        Image(imageName)
          .scaledToFit()
          .frame(width: geo.size.width * widthPercent(21), height: geo.size.height * heightPercent(21))
        
        VStack(alignment: .leading, spacing: 0) {
          
          Text(captionText)
            .foregroundColor(.secondary)
          
          HStack {
            
            if secured {
              SecureField("", text: $text)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .padding(.bottom, geo.size.height * heightPercent(6.5))
              
            } else {
              TextField("", text: $text)
                .userInteractable()
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .padding(.bottom, geo.size.height * heightPercent(6.5))

            }
            
            Button(action: {
              self.secured.toggle()
            }, label: {
              Image("ShowPassword")
//                .padding(.init(top: 17, leading: 0, bottom: 9.5, trailing: 0))
            })
//            .padding(EdgeInsets(top: geo.size.height * heightPercent(17), leading: 0, bottom: geo.size.height * heightPercent(9.5), trailing: 0))
          }
          Rectangle()
            .frame(height: 1)
            .foregroundColor(Color(.displayP3, red: 232 / 255, green: 233 / 255, blue: 234 / 255))
        }// VStack
      } // HStack
      .frame(height: geo.size.height * heightPercent(43.5))
    }
  } // body
}

struct PasswordView_Previews: PreviewProvider {
  static var previews: some View {
    PasswordView(text: .constant("somePassword"), secured: .constant(true), imageName: "MailImg", captionText: "Password")
  }
}
