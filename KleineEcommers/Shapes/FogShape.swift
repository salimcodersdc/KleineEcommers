//
//  FogShape.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

struct FogShape: Shape {
    
    var diversion: CGFloat
    
    var animatableData: CGFloat {
        get { diversion }
        set { diversion = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        let width = rect.size.width * 1.65
        let height = rect.size.height * 1.35
        
        let sourcePoint = CGPoint(
            x: 0.21245237380739243*width + diversion,
            y: 0.6614404708620102*height - diversion
        )
        let sourceControl1 = CGPoint(
            x: 0.257656733194987*width - diversion,
            y: 0.7002183217850942*height + diversion
        )
        let sourceControl2 = CGPoint(
            x: 0.21245237380739243*width + diversion,
            y: 0.6614404708620102*height - diversion
        )
        
        path.move(to: sourcePoint)
        path.addCurve(to: CGPoint(x: 0.43186705453055246*width, y: 0.2902777838328528*height), controlPoint1: CGPoint(x: 0.02375198356688969*width, y: 0.5216408986893911*height), controlPoint2: CGPoint(x: 0.1930555616106306*width, y: 0.2417063486008417*height))
        path.addCurve(to: CGPoint(x: 0.7303571549672929*width, y: 0.6614404708620102*height), controlPoint1: CGPoint(x: 0.6706785474504743*width, y: 0.3388492190648639*height), controlPoint2: CGPoint(x: 0.7754464527917286*width, y: 0.48731943160768537*height))
        
        let point1 = CGPoint(
            x: 0.6803571534535241*width - diversion,
            y: 0.9754404643225292*height - diversion
        )
        
        let point1Control1 = CGPoint(
            x: 0.6852678571428571*width - diversion,
            y: 0.835561510116335*height + diversion
        )
        let point1Control2 = CGPoint(
            x: 0.7637976313394214*width - diversion,
            y: 0.8803888805328853*height - diversion
        )
        
        path.addCurve(to: point1, controlPoint1: point1Control1, controlPoint2: point1Control2)
        
        path.addCurve(to: CGPoint(x: 0.28304959857274614*width, y: 0.8644841512044271*height), controlPoint1: CGPoint(x: 0.596916675567627*width, y: 1.070492048112173*height), controlPoint2: CGPoint(x: 0.30844246395050534*width, y: 1.0287499806237599*height))
        path.addCurve(to: sourcePoint, controlPoint1: sourceControl1, controlPoint2: sourceControl2)
        path.close()
        
        var transform: CGAffineTransform = .identity
        transform = transform.translatedBy(x: -width * 0.13, y: -height * 0.28)
        path.apply(transform)
        
        return Path(path.cgPath)
    }
}
