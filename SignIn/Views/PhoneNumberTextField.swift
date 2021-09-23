//
//  PhoneNumberTextField.swift
//  SignIn
//
//  Created by Дмитрий Геращенко on 08.09.2021.
//

import SwiftUI

struct PhoneNumberTextField: View {
  
  @Binding var text: String
  
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
          
//                    TextField("", text: $text)
          PhoneNumberUITextField(phoneNumber: $text)
            .keyboardType(.numberPad)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .padding(.bottom, geo.size.height * heightPercent(6.5))

          Rectangle()
            .frame(height: 1)
            .foregroundColor(Color(.displayP3, red: 232 / 255, green: 233 / 255, blue: 234 / 255))
        } // VStack
      } // HStack
      .frame(height: geo.size.height * heightPercent(43.5))
    }
  } // body
}

struct PhoneNumberTextField_Previews: PreviewProvider {
  static var previews: some View {
    PhoneNumberTextField(text: .constant("9521821922"), imageName: "Phone", captionText: "Your Phone")
  }
}
