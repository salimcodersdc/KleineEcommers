//
//  UnAuthChoiceScreen.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

struct UnAuthChoiceScreen: View {
    
    @Binding var page: UnAuthController.Page
    
    var body: some View {
        ZStack {
            VStack {
                Text("Choice")
            }
        }
    }
}

struct UnAuthChoiceScreen_Previews: PreviewProvider {
    static var previews: some View {
        UnAuthChoiceScreen(page: .constant(.choice))
    }
}
