//
//  ContentView.swift
//  SignIn
//
//  Created by Дмитрий Геращенко on 30.08.2021.
//

import SwiftUI
import Combine

struct ContentView: View {
  
  @ObservedObject private var userViewModel = UserViewModel()
  
  @State private var secured = true
    
  var body: some View {
    
    GeometryReader { geo in
      
      VStack(alignment: .center, spacing: 0) {
        
        Text("Sign In")
          .font(
            Font.custom("SEGOEUI", size: geo.size.height * heightPercent(30))
          )
          .lineLimit(0)
          .frame(width: geo.size.width * widthPercent(88), height: geo.size.height * heightPercent(40))
          .padding(.init(top: geo.size.height * heightPercent(70), leading: 0, bottom: geo.size.height * heightPercent(10), trailing: 0))
        
        Text("Fill the details & create your account")
          .font(
            Font.custom("SEGOEUI", size: 16)
          )
          .frame(width: geo.size.width * widthPercent(311), height: geo.size.height * heightPercent(28))
          .padding(.bottom, geo.size.height * heightPercent(22.7))
        
        Image("UserLogImage")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: geo.size.width * widthPercent(269.56), height: geo.size.height * heightPercent(247.27))
          .padding(.bottom, geo.size.height * heightPercent(29))

        // MARK: User Data input
        
        VStack(
          alignment: .leading,
          spacing: geo.size.height * heightPercent(16.5)
        ) {
          UnderlineTextFieldView(text: $userViewModel.email, imageName: "MailImg", captionText: "Mail")
          
          PasswordView(text: $userViewModel.password, secured: $secured, imageName: "MailImg", captionText: "Password")
          
          PhoneNumberTextField(text: $userViewModel.phoneNumber, imageName: "Phone", captionText: "Your phone")
        }
        .frame(width: geo.size.width * widthPercent(340), height: geo.size.height * heightPercent(163.5))
        .padding(.init(top: 0, leading: geo.size.width * widthPercent(18), bottom: geo.size.height * heightPercent(51.5), trailing: geo.size.width * widthPercent(17)))
        
        //  MARK: Sign In Button
        
        NavigationLink(destination: EmptyView()) {
          
          Button(action: {
            
          }) {
            Text("Sign In")
          }
          .foregroundColor(.white)
          .frame(width: geo.size.width * widthPercent(259), height: geo.size.height * heightPercent(50))
          .background(
            RoundedRectangle(cornerRadius: 12)
              .fill(Color(.sRGB, red: 255 / 255, green: 62 / 255, blue: 46 / 255, opacity: 1))
              .shadow(color: Color(.sRGB, red: 255 / 255, green: 62 / 255, blue: 46 / 255, opacity: 1), radius: 14, x: 6, y: 3)
          )
          .opacity(!userViewModel.isValid ? 0.7 : 1)
          .disabled(!userViewModel.isValid)
          .padding(.bottom, geo.size.height * heightPercent(29))
        }
        
        HStack {
          Text("Don't have an account?")
            .lineLimit(0)
          
          NavigationLink(destination: EmptyView()) {
            Text("Sign Up")
              .bold()
              .foregroundColor(.blue)
          }
        }
        .frame(width: geo.size.width * widthPercent(226), height: geo.size.height * heightPercent(21))
        .padding(.bottom, geo.size.height * heightPercent(50))
      }
      
      .frame(width: geo.size.width, height: geo.size.height)
      .foregroundColor(Color(.sRGB, red: 64 / 255, green: 89 / 255, blue: 96 / 255, opacity: 1))
      .edgesIgnoringSafeArea(.top)
    }
    .onTapGesture {
      self.hidekeyboard()
    }
  }
}

extension View {
  
  func hidekeyboard() {
    let resign = #selector(UIResponder.resignFirstResponder)
    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
  }
  
  func heightPercent(_ number: CGFloat) -> CGFloat {
    let height: CGFloat = 812
    return number / height
  }
  
  func widthPercent(_ number: CGFloat) -> CGFloat {
    let width: CGFloat = 375
    return number / width
  }

  func userInteractable() -> some View {
    ModifiedContent(content: self, modifier: UserInteractable())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
