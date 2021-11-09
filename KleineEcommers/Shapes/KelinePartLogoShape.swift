//
//  KelinePartLogoShape.swift
//  ArchitectureTestingApp
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

struct KelinePartLogoShape: Shape  {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let center = CGPoint(x: rect.maxX, y: rect.midY)
            path.move(to: center)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addArc(
                center: center,
                radius: rect.width,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 180),
                clockwise: false)
            
            path.addLine(to: center)
        }
    }
}

