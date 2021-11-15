//
//  CameraShape.swift
//  KleineEcommers
//
//  Created by Yousef on 11/15/21.
//

import SwiftUI

struct CameraShape: Shape {
    let padding: CGFloat = 25
    let depth: CGFloat = 75
    let cornerRadius: CGFloat = 10
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let p1 = CGPoint(x: padding, y: padding)
            
            path.move(to: CGPoint(x: p1.x, y: p1.y + depth))
            path.addLine(to: p1)
            path.addLine(to: CGPoint(x: p1.x + depth, y: p1.y))
            
            let p2 = CGPoint(x: rect.maxX - padding, y: padding)
            path.move(to: CGPoint(x: p2.x, y: p2.y + depth))
            path.addLine(to: CGPoint(x: p2.x, y: p2.y + depth))
            path.addLine(to: p2)
            path.addLine(to: CGPoint(x: p2.x - depth, y: p2.y))
            
            let p3 = CGPoint(x: rect.maxX - padding, y: rect.maxY - padding)
            path.move(to: CGPoint(x: p3.x, y: p3.y - depth))
            path.addLine(to: CGPoint(x: p3.x, y: p3.y - depth))
            path.addLine(to: p3)
            path.addLine(to: CGPoint(x: p3.x - depth, y: p3.y))
            
            let p4 = CGPoint(x: padding, y: rect.maxY - padding)
            path.move(to: CGPoint(x: p4.x + depth, y: p4.y))
            path.addLine(to: CGPoint(x: p4.x + depth, y: p4.y))
            path.addLine(to: p4)
            path.addLine(to: CGPoint(x: p4.x, y: p3.y - depth))
        }
    }
}

struct TestCameraShape: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.green)
                .frame(width: 300, height: 300)
                .overlay(CameraShape().stroke(Color.white, lineWidth: 2))
        }
    }
}

struct TestCameraShape_Previews: PreviewProvider {
    static var previews: some View {
        TestCameraShape()
    }
}
