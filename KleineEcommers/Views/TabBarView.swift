//
//  TabBarView.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var selection: AuthController.TabBarItem
    
    var items = AuthController.TabBarItem.allCases
    
    var body: some View {
        HStack {
            ForEach(items) { item in
                Spacer(minLength: 0)
                TabBarButton(item: item, selection: $selection)
            }
            Spacer(minLength: 0)
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 60)
        .background(
            Color.theme.tertiary
                .cornerRadius(16)
        )
        .padding(.bottom, 32)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            
            Text("HI")
            Spacer()
            
            TabBarView(selection: .constant(.home))
        }
    }
}


struct TabBarButton: View {
    var item: AuthController.TabBarItem
    @Binding var selection: AuthController.TabBarItem
    
    var body: some View {
        Button(action: {
            selection = item
        }, label: {
            Image(item.icon)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(selection == item ? Color.theme.primary : Color.theme.secondary)
            
            if selection == item {
                Text(item.id)
                    .font(Font.fontBook.bold(15))
                    .foregroundColor(Color.theme.primary)
            }
        })
    }
}
