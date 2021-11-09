//
//  KelineMobile.swift
//  ArchitectureTestingApp
//
//  Created by Yousef on 11/8/21.
//

import SwiftUI

struct KelineOutterMobileShape: Shape {
    var radius: CGFloat = 24
    var padding: CGFloat = 12
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let p1 = CGPoint(x: rect.minX + radius + padding, y: rect.minY + padding)
            
            let p2 = CGPoint(x: rect.maxX - radius - padding, y: rect.minY + padding)
            
            let firstCornerCenter = CGPoint(x: rect.maxX - radius - padding, y: rect.minY + radius + padding)
            let p3 = CGPoint(x: rect.maxX - padding, y: rect.maxY - radius - padding)
            
            let secondCornerCenter = CGPoint(x: rect.maxX - radius - padding, y: rect.maxY - radius - padding)
            let p4 = CGPoint(x: rect.minX + radius + padding, y: rect.maxY - padding)
            
            let thirdCornerCenter = CGPoint(x: rect.minX + radius + padding, y: rect.maxY - radius - padding)
            let p5 = CGPoint(x: rect.minX + padding, y: rect.minY + radius + padding)
            
            let forthCornerCenter = CGPoint(x: rect.minX + radius + padding, y: rect.minY + radius + padding)
            
            path.move(to: p1)
            path.addLine(to: p2)
            path.addArc(
                center: firstCornerCenter,
                radius: radius,
                startAngle: Angle(degrees: 270),
                endAngle: Angle(degrees: 0),
                clockwise: false)
            path.addLine(to: p3)
            
            path.addArc(
                center: secondCornerCenter,
                radius: radius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 90),
                clockwise: false)
            path.addLine(to: p4)
            path.addArc(
                center: thirdCornerCenter,
                radius: radius,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 180),
                clockwise: false)
            
            path.addLine(to: p5)
            
            path.addArc(
                center: forthCornerCenter,
                radius: radius,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 0),
                clockwise: false)
            
            
            let nudgeWidth = padding / 1.5
            let nudgeHeight: CGFloat = 80
            let thirdStart = (rect.height * 0.48) - nudgeHeight
            
            let secondStart = thirdStart - 95
            
            let firstSideNudge = CGPoint(x: rect.minX + padding, y: thirdStart )
            let firstSideNudge2 = CGPoint(x: rect.minX + nudgeWidth, y: thirdStart)
            path.move(to: firstSideNudge)
            
            path.addRoundedRect(in: CGRect(x: firstSideNudge2.x, y: firstSideNudge2.y, width: nudgeWidth * 2, height: nudgeHeight), cornerSize: CGSize(width: 8, height: 8))
            
            let secondSideNudge = CGPoint(x: rect.minX + padding, y: secondStart)
            let secondSideNudge2 = CGPoint(x: rect.minX + nudgeWidth, y: secondStart)
            path.move(to: secondSideNudge)
            
            path.addRoundedRect(in: CGRect(x: secondSideNudge2.x, y: secondSideNudge2.y, width: nudgeWidth * 2, height: nudgeHeight), cornerSize: CGSize(width: 8, height: 8))
            
            let firstStart = secondStart - 60
            let thirdSideNudge = CGPoint(x: rect.minX + padding, y: firstStart)
            let thirdSideNudge2 = CGPoint(x: rect.minX + nudgeWidth, y: firstStart)
            path.move(to: thirdSideNudge)
            
            path.addRoundedRect(in: CGRect(x: thirdSideNudge2.x, y: thirdSideNudge2.y, width: nudgeWidth * 2, height: 40), cornerSize: CGSize(width: 8, height: 8))
            
        }
    }
}

struct KelineInnerMobileShape: Shape {
    var radius: CGFloat = 24
    var padding: CGFloat = 22
    
    
    var nudgeRadius: CGFloat = 6
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            let nudgeHalfWidth: CGFloat = (rect.width - (2 * padding)) / 4
            let p1 = CGPoint(x: rect.minX + radius + padding, y: rect.minY + padding)
            
            let nudgeStart = CGPoint(
                x: rect.midX - nudgeHalfWidth,
                y: rect.minY + padding
            )
            
            let nudgeStartCenter = CGPoint(
                x: rect.midX - nudgeHalfWidth + nudgeRadius,
                y:  rect.minY + padding + nudgeRadius
            )
            
            let nudgeStartCenter2 = CGPoint(
                x: rect.midX - nudgeHalfWidth + nudgeRadius + nudgeRadius + nudgeRadius,
                y:  rect.minY + padding + nudgeRadius + nudgeRadius
            )
            
            let tempPoint = CGPoint(
                x: rect.midX + nudgeHalfWidth - nudgeRadius - nudgeRadius,
                y: rect.minY + padding + nudgeRadius + nudgeRadius + nudgeRadius
            )
            
            let nudgeEndCenter2 = CGPoint(
                x: tempPoint.x,
                y:  tempPoint.y - nudgeRadius
            )
            
            
            
            let nudgeEnd = CGPoint(x: rect.midX + nudgeHalfWidth, y: rect.minY + padding)
            
            let nudgeEndCenter = CGPoint(
                x: nudgeEnd.x,
                y: nudgeEnd.y + nudgeRadius
            )
            
            let p2 = CGPoint(x: rect.maxX - radius - padding, y: rect.minY + padding)
            
            let firstCornerCenter = CGPoint(x: rect.maxX - radius - padding, y: rect.minY + radius + padding)
            let p3 = CGPoint(x: rect.maxX - padding, y: rect.maxY - radius - padding)
            
            let secondCornerCenter = CGPoint(x: rect.maxX - radius - padding, y: rect.maxY - radius - padding)
            let p4 = CGPoint(x: rect.minX + radius + padding, y: rect.maxY - padding)
            
            let thirdCornerCenter = CGPoint(x: rect.minX + radius + padding, y: rect.maxY - radius - padding)
            let p5 = CGPoint(x: rect.minX + padding, y: rect.minY + radius + padding)
            
            let forthCornerCenter = CGPoint(x: rect.minX + radius + padding, y: rect.minY + radius + padding)
            
            path.move(to: p1)
            path.addLine(to: nudgeStart)
            path.addArc(
                center: nudgeStartCenter,
                radius: nudgeRadius,
                startAngle: Angle(degrees: 270),
                endAngle: Angle(degrees: 0),
                clockwise: false)
            
            path.addArc(
                center: nudgeStartCenter2,
                radius: nudgeRadius,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 90),
                clockwise: true)
            
            
            path.addLine(to: tempPoint)
            path.addArc(
                center: nudgeEndCenter2,
                radius: nudgeRadius,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 0),
                clockwise: true)
            
            path.addArc(
                center: nudgeEndCenter,
                radius: nudgeRadius,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 270),
                clockwise: false)
            
            
            path.addLine(to: nudgeEnd)
            path.addLine(to: p2)
            path.addArc(
                center: firstCornerCenter,
                radius: radius,
                startAngle: Angle(degrees: 270),
                endAngle: Angle(degrees: 0),
                clockwise: false)
            path.addLine(to: p3)
            
            path.addArc(
                center: secondCornerCenter,
                radius: radius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 90),
                clockwise: false)
            path.addLine(to: p4)
            path.addArc(
                center: thirdCornerCenter,
                radius: radius,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 180),
                clockwise: false)
            
            path.addLine(to: p5)
            
            path.addArc(
                center: forthCornerCenter,
                radius: radius,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 0),
                clockwise: false)
        }
    }
}

struct KelineMobile: View {
    
    var dark: Color = Color.fromHexString("#B0B6FF")
    var light: Color = Color.fromHexString("#F5F8FA")
    
    var body: some View {
        ZStack {
            KelineOutterMobileShape()
                .fill(dark)
            
            KelineInnerMobileShape()
                .fill(light)
            
        }
    }
    
    func darkColor(_ color: Color) -> KelineMobile {
        var view = self
        view.dark = color
        return view
    }
    
    func lightColor(_ color: Color) -> KelineMobile {
        var view = self
        view.light = color
        return view
    }
}
