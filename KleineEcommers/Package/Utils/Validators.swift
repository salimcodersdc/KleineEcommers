//
//  Validators.swift
//  KleineEcommers
//
//  Created by Yousef on 11/11/21.
//

import Foundation

// password patterns
/*
 // At least 8 characters
     #"(?=.{8,})"# +

     // At least one capital letter
     #"(?=.*[A-Z])"# +
         
     // At least one lowercase letter
     #"(?=.*[a-z])"# +
         
     // At least one digit
     #"(?=.*\d)"# +
         
     // At least one special character
     #"(?=.*[ !$%&?._-])"#
 */

// Validator.userName.predicate.evaluate(with: value)

fileprivate enum Validator: String {
    case email
    case complexPassword
    case simplePassword
    case userName
    case fullName
    case phone
    
    static var minUserNameLength: Int = 5
    
    static var minPhoneLength: Int = 8
    static var maxPhoneLength: Int = 13
    
    static var minComplexPasswordLength: Int = 8
    
    static var minSimplePasswordLength: Int = 6
    static var maxSimplePasswordLength: Int = 10
    
    static var minNameLengthForFullName: Int = 3
    static var maxNameLengthForFullName: Int = 10
    
    var predicate: NSPredicate {
        switch self {
        
        case .email:
            return NSPredicate(format: "SELF MATCHES %@", "(?:[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
        case .complexPassword:
            return NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*\\W)[A-Za-z\\d\\W]{\(Self.minComplexPasswordLength),}$")
        case .simplePassword:
            return NSPredicate(format: "SELF MATCHES %@", "^.{\(Self.minSimplePasswordLength),\(Self.maxSimplePasswordLength)}$")
        case .userName:
            return NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9]{\(Self.minUserNameLength),}\\s[a-zA-Z0-9]{\(Self.minUserNameLength),}")
        case .phone:
            return NSPredicate(format: "SELF MATCHES %@", "^\\+?[0-9]{\(Self.minPhoneLength),\(Self.maxPhoneLength)}")
        case .fullName:
            return NSPredicate(format: "SELF MATCHES %@", "^[A-Za-z][A-Za-z0-9]{\(Self.minNameLengthForFullName),\(Self.maxNameLengthForFullName)}\\s[A-Za-z][A-Za-z0-9]{\(Self.minNameLengthForFullName),\(Self.maxNameLengthForFullName)}$")
        }
    }
}

extension String {
    var isValidEmail: Bool {
        Validator.email.predicate.evaluate(with: self)
    }
    
    var isValidComplexPassword: Bool {
        Validator.complexPassword.predicate.evaluate(with: self)
    }
    
    var isValidUserName: Bool {
        Validator.userName.predicate.evaluate(with: self)
    }
    
    var isValidPhone: Bool {
        Validator.phone.predicate.evaluate(with: self)
    }
    
    var isValidSimplePassword: Bool {
        Validator.simplePassword.predicate.evaluate(with: self)
    }
    
    var isValidFullName: Bool {
        Validator.fullName.predicate.evaluate(with: self)
    }
}
