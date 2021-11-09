//
//  Font+Extension.swift
//  PlaygroundForTesting
//
//  Created by Yousef on 10/20/21.
//

import SwiftUI

extension Font {
    
    static var book = FontsBook()
    
//    static func appRegular(size: CGFloat) -> Font {
//        Font.custom("Cairo-Regular", size: size)
//    }
//
//    static func appSemiBold(size: CGFloat) -> Font {
//        Font.custom("Cairo-SemiBold", size: size)
//    }
//
//    static func appBold(size: CGFloat) -> Font {
//        Font.custom("Cairo-Bold", size: size)
//    }
}

struct FontsBook {
    func regular(_ size: CGFloat = 16) -> Font {
//        Font.custom("Cairo-Regular", size: size)
        Font.system(size: size, weight: .regular)
    }
    
    func semiBold(_ size: CGFloat = 16) -> Font {
//        Font.custom("Cairo-SemiBold", size: size)
        Font.system(size: size, weight: .semibold)
    }
    
    func bold(_ size: CGFloat = 16) -> Font {
//        Font.custom("Cairo-Bold", size: size)
        Font.system(size: size, weight: .bold)
    }
}
