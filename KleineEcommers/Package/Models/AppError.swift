//
//  AppError.swift
//  ArchitectureTestingApp
//
//  Created by Yousef on 10/26/21.
//

import Foundation

struct AppError: Error, Identifiable {
    let id = UUID().uuidString
    let message: String
}
