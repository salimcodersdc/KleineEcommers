//
//  CustomNavigationView.swift
//  PlaygroundForTesting
//
//  Created by Yousef on 10/8/21.
//

import SwiftUI

struct CustomNavigationView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            CustomNavBarContainerView {
                content
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView {
            VStack {
                Text("Hi There")
            }
        }
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = nil
    }
}
