//
//  UnderlineTextFieldView.swift
//  SignIn
//
//  Created by Дмитрий Геращенко on 06.09.2021.
//

import SwiftUI

struct UnderlineTextFieldView: View {
  
  @Binding var text: String
  
  var imageName: String
  var captionText: String
  
  var body: some View {
    GeometryReader { geo in
      
      HStack(alignment: .center) {
        Image(imageName)
          .scaledToFit()
          .frame(width: geo.size.width * widthPercent(21), height: geo.size.height * heightPercent(21))
        
        VStack(alignment: .leading, spacing: 0) {
          
          Text(captionText)
            .foregroundColor(.secondary)
          
          TextField("", text: $text)
            .keyboardType(.emailAddress)
            .userInteractable()
            .ignoresSafeArea(.keyboard, edges: .bottom)

          Rectangle()
            .frame(height: 1)
            .foregroundColor(Color(.displayP3, red: 232 / 255, green: 233 / 255, blue: 234 / 255))
        }
      }
      .frame(height: geo.size.height * heightPercent(43.5))
    }
  }
}

struct UnderlineTextFieldView_Previews: PreviewProvider {
  static var previews: some View {
    UnderlineTextFieldView(text: .constant("dv.gerashchenko@gmail.com"), imageName: "MailImg", captionText: "Mail")
  }
}
