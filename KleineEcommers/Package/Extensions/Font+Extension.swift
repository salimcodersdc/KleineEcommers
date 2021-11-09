//
//  Font+Extension.swift
//  PlaygroundForTesting
//
//  Created by Yousef on 10/20/21.
//

import SwiftUI

extension Font {
    
    static var fontBook = FontsBook()
    
}

struct FontsBook {
    func regular(_ size: CGFloat = 16) -> Font {
        Font.custom("Poppins-Regular", size: size)
    }
    
    func semiBold(_ size: CGFloat = 16) -> Font {
        Font.custom("Poppins-SemiBold", size: size)
    }
    
    func bold(_ size: CGFloat = 16) -> Font {
        Font.custom("Poppins-Bold", size: size)
    }
}
