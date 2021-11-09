//
//  CustomNavBarContainerView.swift
//  PlaygroundForTesting
//
//  Created by Yousef on 10/8/21.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    
    let content: Content
    
    @State private var backButtonHidden: Bool = false
    @State private var title: String = ""
    @State private var subtitle: String? = nil
    
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(backButtonHidden: backButtonHidden, title: title, subtitle: subtitle)
            
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavigationViewTitlePrefrenceKey.self, perform: { value in
            title = value
        })
        .onPreferenceChange(CustomNavigationViewSubtitlePrefrenceKey.self, perform: { value in
            subtitle = value
        })
        .onPreferenceChange(CustomNavigationViewBackButtonHidden.self, perform: { value in
            backButtonHidden = value
        })
    }
}


struct CustomNavBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainerView {
            ZStack {
                Color.green.edgesIgnoringSafeArea(.bottom)
                
                Text("Hello There")
            }
        }
    }
}
