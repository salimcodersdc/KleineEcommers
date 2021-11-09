//
//  TestLoadingView.swift
//  PlaygroundForTesting
//
//  Created by Yousef on 9/7/21.
//

import SwiftUI

private struct CircularActivityIndicatorMask: View {
    
    @State private var animating = false
    
//    let gradient = Gradient(colors: [
//        Color.red.opacity(0),
//        Color.red,
//    ])
    let gradient = Gradient(stops: [
        .init(color: Color.red.opacity(0), location: 0.4),
        .init(color: Color.red, location: 1)
    ])
    
    var body: some View {
        
        AngularGradient(gradient: gradient,
                        center: .center,
                        angle: animating ? Angle.degrees(360) : Angle.degrees(0))
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    animating = true
                }
            }
    }
}

private struct LinearActivityIndicatorMask: View {
    let width: CGFloat
    @State private var animating = false
    
    let gradient = Gradient(stops: [
        .init(color: Color.red.opacity(0), location: 0.0),
        .init(color: Color.red.opacity(0), location: 0.35),
        .init(color: Color.red, location: 0.5),
        .init(color: Color.red.opacity(0), location: 0.7),
        .init(color: Color.red.opacity(0), location: 1)
    ])
    
    var body: some View {
        
        LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing)
            .offset(x: animating ? width * 0.6 : -width * 0.6)
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: true)) {
                    animating = true
                }
            }
    }
}

struct CircularActivityIndicatorDemo: View {
    var body: some View {
        GeometryReader { (geo: GeometryProxy) in
            let numSegments = 12
            let fractionalRotationPerSegment = 360 / Double(numSegments)
            ZStack {
                Color.clear
                ForEach(0..<numSegments) { index in
                    Capsule()
                        .frame(width: geo.size.width * 0.15, height: geo.size.height * 0.06)
                        .offset(x: -geo.size.width * 0.37)
                        .rotationEffect(Angle.degrees(fractionalRotationPerSegment * Double(index)))
//                        .rotate(.cycle(fractionalRotationPerSegment * index.asDouble))
                }
            }
            .mask(
//            .background(
                CircularActivityIndicatorMask()
                    .scaleEffect(1.2)
                    .blur(radius: geo.size.width * 0.05)
            )
        }
    }
}

struct LinearActivityIndicatorDemo: View {
    
    let numSegments: Int = 12
    @State var segmentWidth: CGFloat = 5
    @State var segmentHeight: CGFloat = 50
    @State var columns = Array<GridItem>()
    @State var text: String = ""
    
    var body: some View {
        
        
        GeometryReader { geo -> AnyView in
            
            DispatchQueue.main.async {
                segmentWidth = geo.size.width / CGFloat(numSegments)
                segmentHeight = geo.size.height
                text = "\(Int(geo.size.width)) / \(numSegments) = \(Int(segmentWidth))"
            }
            
            return AnyView(
                HStack(spacing: 0) {
                    ForEach(0..<numSegments) { index in
                        
                        HStack {
                            Capsule()
                                .frame(width: 10)
                        }
                        .frame(width: segmentWidth, height: segmentHeight)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(
                .mask(
                    LinearActivityIndicatorMask(width: geo.size.width)
                        .scaleEffect(1.2)
                        .blur(radius: geo.size.width * 0.05)
                )
            )
            
            
        }
    }
    
    private func getWidth() -> CGFloat {
        return segmentWidth
    }
}

//struct LoadingView: View {
//    
//    @State var animating: Bool = false
//    
//    let gradient = Gradient(colors: [
//        Color.red.opacity(0),
//        Color.red,
//        Color.red.opacity(0)
//    ])
//    
////    let temp = Gradient(stops: [Gradient.Stop])
//    
//    var body: some View {
//        ZStack {
//            Circle()
//                .stroke(Color.orange, lineWidth: 10)
//                .padding()
//                .onAppear {
//                    animating = true
//                }
//        }
//        .frame(width: 100, height: 100)
//        .mask(
////        .background(
//            CircularActivityIndicatorMask()
//                .scaleEffect(1.2)
////                .blur(radius: geo.size.width * 0.05)
//        )
//    }
//}

struct ArcShape: Shape {
    
    var angle: Double
    
    var animatableData: Double {
        get { return angle }
        set { angle = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = (min(rect.width, rect.height) / 2) - 10
            path.addArc(center: center, radius: radius, startAngle: Angle.degrees(angle), endAngle: Angle.degrees(angle + 160.0), clockwise: true)
        }
    }
}

struct AnotherLoadingView: View {
    
    @State private var animating = false
    
    var body: some View {
        ZStack {
            ArcShape(angle: animating ? 360 : 0)
                .stroke(Color.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .onAppear {
                    withAnimation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                        animating = true
                    }
                }
        }
    }
}

struct TestLoadingView: View {
    
    @State var loading: Bool = true
    
    var body: some View {
        VStack(spacing: 20) {
            LinearActivityIndicatorDemo()
                .frame(width: 300, height: 40)
            
            CircularActivityIndicatorDemo()
                .frame(width: 100, height: 100)
            
            LoadingView()
            
            AnotherLoadingView()
                .frame(width: 100, height: 100)
            
            LoaderWithImage(loading: $loading)
                .frame(width: 100, height: 100)
            
            Button("Toggle Loading") {
                loading.toggle()
            }
            
        }
    }
}

struct TestLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        TestLoadingView()
    }
}


struct LoaderWithImage: View {
    @Binding var loading: Bool
    @State private var animating = false
    @State private var opacity: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.5))
            
//            Image(systemName: "doc.fill")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 44, height: 44)
//                .foregroundColor(.white)
            
            Text("🤔")
                .font(.system(size: 66, weight: .regular))
                
        }
        .overlay(
            ArcShapeNew(angle: animating ? 360 : 0)
                .stroke(Color.orange, lineWidth: 5)
                .opacity(opacity ? 1 : 0)
                
        )
        .onAppear {
            opacity = true
            withAnimation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                animating = true
            }
        }
        .onChange(of: loading, perform: { value in
            opacity = value
            animating = value
        })
    }
}

struct ArcShapeNew: Shape {
    
    var angle: Double
    
    var animatableData: Double {
        get { return angle }
        set { angle = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = (min(rect.width, rect.height) / 2)
            path.addArc(center: center, radius: radius, startAngle: Angle.degrees(angle), endAngle: Angle.degrees(angle + 40.0), clockwise: false)
        }
    }
}
