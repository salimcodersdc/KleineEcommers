//
//  AppNavBarView.swift
//  PlaygroundForTesting
//
//  Created by Yousef on 10/8/21.
//

import SwiftUI

struct AppNavBarView: View {
    
    @State private var text: String? = nil
    @State private var originalLink: String? = nil
    
    var body: some View {
        CustomNavigationView {
            ZStack {
                
                Color.gray.opacity(0.3).ignoresSafeArea()
                
                VStack(spacing: 32) {
                    
                    
                    Button(action: {
                        if text == nil {
                            originalLink = "Original Link"
                            text = "Test"
                        } else {
                            originalLink = nil
                            text = nil
                        }
                    }, label: {
                        Text("Go there")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(width: 300, height: 44)
                            .background(Color.green)
                            .cornerRadius(12)
                            .foregroundColor(.white)
                    })
                }
            }
            .background(
                CustomNavigationLink(
                    "",
                    destination:
                        Text("Some thing")
                        .customNavigationItems(title: "Child is here", subtitle: "What ever", backButtonHidden: false)
                    ,
                    tag: text ?? "something",
                    selection: $text
                )
            )
            .overlay(
                appTabView
                ,alignment: .bottom
            )
            .customNavigationItems(title: "Some thing else", subtitle: nil, backButtonHidden: true)
        }
    }
}

extension AppNavBarView {
    
    private var appTabView: some View {
        HStack(spacing: 0) {
            Button(action: {}, label : {
                Image(systemName: "house.fill")
            })
            Spacer(minLength: 0)
            Image(systemName: "gear")
            Spacer(minLength: 0)
            Image(systemName: "envelope.fill")
            Spacer(minLength: 0)
            Image(systemName: "house.fill")
        }
        .font(.title)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .padding(.horizontal)
        .background(
            Color.blue
                .edgesIgnoringSafeArea(.bottom)
        )
    }
    
    private var defaultNavView: some View {
        NavigationView {
            ZStack {
                
                Color.green.ignoresSafeArea()
                
                NavigationLink(
                    destination:
                        Text("Destination")
                        .navigationTitle("Child Tilte")
                    ,
                    label: {
                        Text("Navigate")
                    })
            }
            .navigationTitle("Title Here")
        }
    }
}

struct AppNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBarView()
    }
}
