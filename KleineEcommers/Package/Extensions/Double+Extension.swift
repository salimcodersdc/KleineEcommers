//
//  Double+Extension.swift
//  ArchitectureTestingApp
//
//  Created by Yousef on 10/27/21.
//

import Foundation

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}
