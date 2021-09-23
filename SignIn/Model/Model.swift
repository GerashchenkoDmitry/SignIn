//
//  Model.swift
//  SignIn
//
//  Created by Дмитрий Геращенко on 13.09.2021.
//

import Foundation

struct User: Codable {
  
  var email: String?
  var password: String?
  var phoneNumber: String?
  
  static var placeHolder: Self {
    return User(email: nil, password: nil, phoneNumber: nil)
  }
}
