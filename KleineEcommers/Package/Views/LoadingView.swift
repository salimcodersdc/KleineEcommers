//
//  LoadingView.swift
//  ArchitectureTestingApp
//
//  Created by Yousef on 10/26/21.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var loading: Bool = true
    
    var body: some View {
        ZStack {
            VStack {
                LoaderWithImage(loading: $loading)
                    .frame(width: 100, height: 100)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
