//
//  ProductType.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import Foundation

enum ProductType: Identifiable, CaseIterable {
    case chair
    case cupboard
    case table
    case accessory
    
    var id: String {
        switch self {
        
        case .chair:
            return "Chair"
        case .cupboard:
            return "Cupboard"
        case .table:
            return "Table"
        case .accessory:
            return "Accessory"
        }
    }
    
}
