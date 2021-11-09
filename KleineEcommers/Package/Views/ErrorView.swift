//
//  ErrorView.swift
//  ArchitectureTestingApp
//
//  Created by Yousef on 10/26/21.
//

import SwiftUI

struct ErrorView: View {
    
    var error: AppError
    
    var body: some View {
        ZStack {
            VStack {
                
                 Image("error")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(error.message)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.primaryText)
                
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: AppError(message: "Bad Response"))
    }
}
