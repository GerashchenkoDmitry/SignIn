//
//  PhoneNumberUITextField.swift
//  SignIn
//
//  Created by Дмитрий Геращенко on 20.09.2021.
//

import Foundation
import SwiftUI

struct PhoneNumberUITextField: UIViewRepresentable {
  
  @Binding var phoneNumber: String
  
  func makeCoordinator() -> Coordinator {
    Coordinator(number: $phoneNumber)
  }
  
  func makeUIView(context: Context) -> UITextField {
    
    let textField = UITextField()
    
    //        textField.borderStyle = .roundedRect
    textField.placeholder = ""
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.spellCheckingType = .no
    textField.keyboardType = .numberPad
    textField.delegate = context.coordinator
//    textField.contentMode = .scaleAspectFit

    return textField
  }
  
  func updateUIView(_ view: UITextField, context: Context) {
    view.text = phoneNumber
  }
}

extension PhoneNumberUITextField {
  
  class Coordinator: NSObject, UITextFieldDelegate {
    
    @Binding var number: String
    
    init(number: Binding<String>) {
      _number = number
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
      DispatchQueue.main.async {
        self.number = textField.text ?? ""
      }
    }
    
    func format(with mask: String, phone: String) -> String {
      
      let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
      var result = ""
      var index = numbers.startIndex // numbers iterator
      
      // iterate over the mask characters until the iterator of numbers ends
      for ch in mask where index < numbers.endIndex {
        if ch == "X" {
          // mask requires a number in this place, so take the next one
          result.append(numbers[index])
          
          // move numbers iterator to the next index
          index = numbers.index(after: index)
          
        } else {
          result.append(ch) // just append a mask character
        }
      }
      return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      guard let text = textField.text else { return false }
      let newString = (text as NSString).replacingCharacters(in: range, with: string)
      textField.text = format(with: "+ X XXX XXX XX XX", phone: newString)
      return false
    }
  }
}
