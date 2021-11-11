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

enum Validator: String {
    case email
    case password
    case userName
    case phone
    
    var predicate: NSPredicate {
        switch self {
        
        case .email:
            return NSPredicate(format: "SELF MATCHES %@", "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
        case .password:
            return NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$")
        case .userName:
            return NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z-]+ ?.* [a-zA-Z-]+$")
        case .phone:
            return NSPredicate(format: "SELF MATCHES %@", "^[0-9+]{0,1}+[0-9]{5,16}$")
        }
    }
}
