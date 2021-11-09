//
//  CustomNavBarView.swift
//  PlaygroundForTesting
//
//  Created by Yousef on 10/8/21.
//

import SwiftUI

struct CustomNavBarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var backButtonHidden: Bool
    var title: String
    var subtitle: String?
    
    var body: some View {
        HStack {
            if !backButtonHidden {
                backButton
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 65)
        .padding(.horizontal)
        .overlay(titlesOverlay)
        .background(
            Color.blue
                .edgesIgnoringSafeArea(.top)
        )
        .accentColor(.white)
        .foregroundColor(.white)
        .font(.headline)
    }
}

extension CustomNavBarView {
    private var titlesOverlay: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            if let subtitle = subtitle {
                Text(subtitle)
            }
        }
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
        })
    }
}


struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavBarView(backButtonHidden: false, title: "Title Here", subtitle: "Subtilte")
            Spacer()
        }
    }
}


