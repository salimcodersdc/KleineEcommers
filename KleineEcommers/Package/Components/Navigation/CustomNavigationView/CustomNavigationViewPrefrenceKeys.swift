//
//  CustomNavigationViewPrefrenceKeys.swift
//  PlaygroundForTesting
//
//  Created by Yousef on 10/8/21.
//

import Foundation
import SwiftUI

struct CustomNavigationViewTitlePrefrenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavigationViewSubtitlePrefrenceKey: PreferenceKey {
    static var defaultValue: String? = nil
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct CustomNavigationViewBackButtonHidden: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

extension View {
    func customNanigationTitle(_ title: String) -> some View {
        preference(key: CustomNavigationViewTitlePrefrenceKey.self, value: title)
    }
    
    func customNanigationSubtitle(_ subtitle: String?) -> some View {
        preference(key: CustomNavigationViewSubtitlePrefrenceKey.self, value: subtitle)
    }
    
    func customNanigationBackButtonHidden(_ hidden: Bool) -> some View {
        preference(key: CustomNavigationViewBackButtonHidden.self, value: hidden)
    }
    
    func customNavigationItems(title: String = "", subtitle: String? = nil, backButtonHidden: Bool = false) -> some View {
        self
            .customNanigationTitle(title)
            .customNanigationSubtitle(subtitle)
            .customNanigationBackButtonHidden(backButtonHidden)
        
    }
    
}
