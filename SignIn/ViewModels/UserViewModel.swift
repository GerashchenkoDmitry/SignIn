//
//  UserViewModel.swift
//  SignIn
//
//  Created by Дмитрий Геращенко on 13.09.2021.
//

import Foundation
import Combine
import Navajo_Swift

final class UserViewModel: ObservableObject {
  
  // input
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var phoneNumber: String = ""
  
  // output
  @Published var isValid: Bool = false
  
  @Published var emailOutput = ""
  @Published var passwordOutput = ""
  @Published var phoneNumberOutput = ""
  
  private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
    $email
      .debounce(for: 0.8, scheduler: RunLoop.main)
      .removeDuplicates()
      .map { input in
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: input)
      }
      .eraseToAnyPublisher()
  }
  
  private var passwordIsEmpty: AnyPublisher<Bool, Never> {
    $password
      .debounce(for: 0.8, scheduler: RunLoop.main)
      .removeDuplicates()
      .map { $0 == "" }
      .eraseToAnyPublisher()
  }
  
  private var passwordStrengthPublisher: AnyPublisher<PasswordStrength, Never> {
    $password
      .debounce(for: 0.2, scheduler: RunLoop.main)
      .removeDuplicates()
      .map { input in
        return Navajo.strength(ofPassword: input)
      }
      .eraseToAnyPublisher()
  }
  
  private var isPasswordStrongEnoughPublisher: AnyPublisher<Bool, Never> {
    
    passwordStrengthPublisher
      .map { strength in
        
        print(Navajo.localizedString(forStrength: strength))
        
        switch strength {
          case .reasonable, .strong, .veryStrong:
            return true
          default:
            return false
          }
      }
      .eraseToAnyPublisher()
  }
  
  enum PasswordCheck {
    case valid, empty, noMatch, notStrongEnough
  }
  
  private var isPasswordValidPublisher: AnyPublisher<PasswordCheck, Never> {
    Publishers.CombineLatest(passwordIsEmpty, isPasswordStrongEnoughPublisher)
      .map { (passwordIsEmpty, passwordStrongEnough) in
        if passwordIsEmpty {
          return .empty
        } else if !passwordStrongEnough {
          return .notStrongEnough
        } else {
          return .valid
        }
      }
      .eraseToAnyPublisher()
  }
  
  private var isPhoneNumberValidPublisher: AnyPublisher<Bool, Never> {
    $phoneNumber
      .debounce(for: 0.8, scheduler: RunLoop.main)
      .removeDuplicates()
      .map { input in
//        let PHONE_REGEX = "^((\\+)|(00))[0-9]{11}$"
        let PHONE_REGEX = "^((\\+7|7|\\+8|8)([0-9]){3}([0-9]){3}([0-9]){2}([0-9]){2})$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        let result =  phoneTest.evaluate(with: input)
        let result =  phoneTest.evaluate(with: input.replacingOccurrences(of: " ", with: ""))

        print(result)
        return result
      }
      .eraseToAnyPublisher()
  }
  
  private var isFormValidPublisher: AnyPublisher<Bool, Never> {
    Publishers.CombineLatest3(isEmailValidPublisher, isPasswordValidPublisher, isPhoneNumberValidPublisher)
      .map { emailIsValid, passwordIsValid, phoneNumberValid in
        return emailIsValid && (passwordIsValid == .valid) && phoneNumberValid
      }
      .eraseToAnyPublisher()
  }
  
  init() {
        
    isEmailValidPublisher
      .receive(on: RunLoop.main)
      .map { valid in
        valid ? "" : "Incorrect email"
      }
      .assign(to: \.emailOutput, on: self)
      .store(in: &cancellableSet)
    
    isPasswordValidPublisher
      .receive(on: RunLoop.main)
      .map { passwordCheck in
        switch passwordCheck {
        case .empty:
          return "Password must not be empty"
        case .notStrongEnough:
          return "Password not strong enough"
        default:
          return ""
        }
      }
      .assign(to: \.passwordOutput, on: self)
      .store(in: &cancellableSet)
    
    isPhoneNumberValidPublisher
      .receive(on: RunLoop.main)
      .map { valid in
        valid ? "" : "Incorrect form phone number"
      }
      .assign(to: \.phoneNumberOutput, on: self)
      .store(in: &cancellableSet)
    
    isFormValidPublisher
      .receive(on: RunLoop.main)
      .assign(to: \.isValid, on: self)
      .store(in: &cancellableSet)
  }

  private var cancellableSet: Set<AnyCancellable> = []
  
}
