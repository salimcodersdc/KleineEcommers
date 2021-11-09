//
//  CustomNavigationLink.swift
//  PlaygroundForTesting
//
//  Created by Yousef on 10/8/21.
//

import SwiftUI

/*
 (_ titleKey: LocalizedStringKey, destination: Destination, tag: V, selection: Binding<V?>) where V : Hashable
 
 init<V>(_ titleKey: LocalizedStringKey, destination: Destination, tag: V, selection: Binding<V?>) where V : Hashable
 */

struct CustomNavigationLink<Destination: View, V: Hashable>: View {
    
    let destination: Destination
    let titleKey: LocalizedStringKey
    var tag: V
    @Binding var selection: V?
    
    
    init(_ titleKey: LocalizedStringKey, destination: Destination, tag: V, selection: Binding<V?>) {
        self.titleKey = titleKey
        self.destination = destination
        self.tag = tag
        self._selection = selection
    }
    
    var body: some View {
        NavigationLink(
            titleKey,
            destination: CustomNavBarContainerView {
                destination
                    .navigationBarHidden(true)
            },
            tag: tag,
            selection: $selection
        )
        .onChange(of: selection, perform: { value in
            print("Value changed here tag: \(tag), selection: \(selection.debugDescription)")
        })
    }
}

struct CustomNavigationLink_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomNavigationView {
            CustomNavigationLink(
                "Hi",
                destination: Text(""),
                tag: "Destination",
                selection: .constant("Destination")
            )
                .customNavigationItems(title: "Test", subtitle: nil, backButtonHidden: true)
        }
    }
}

