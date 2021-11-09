//
//  Color+Extension.swift
//  LooklokServices
//
//  Created by Yousef on 5/11/21.
//

import SwiftUI

extension Color {
    
    static var theme = Palette(name: "Main")
    static var tasksTheme = Theme()
    static var facebookTheme = FacebookTheme()
    
    static func rgb(red: Double, green: Double, blue: Double, opacity: Double = 1) -> Color {
        return Color(red: red / 255, green: green / 255, blue: blue / 255, opacity: opacity)
    }
    
    static func fromHexString(_ hexString: String, alpha: CGFloat = 1.0) -> Color {
        let r,g,b: CGFloat
        let offset = hexString.hasPrefix("#") ? 1: 0
        let start = hexString.index(hexString.startIndex, offsetBy: offset)
        let hexColor = String(hexString[start...])
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            b = CGFloat(hexNumber & 0x0000ff) / 255
            return Color(UIColor(red: r, green: g, blue: b, alpha: alpha))
        }
        return Color(UIColor(red: 0, green: 0, blue: 0, alpha: alpha))
    } 
}


extension UIColor {
    static func fromHexString(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        let r,g,b: CGFloat
        let offset = hexString.hasPrefix("#") ? 1: 0
        let start = hexString.index(hexString.startIndex, offsetBy: offset)
        let hexColor = String(hexString[start...])
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            b = CGFloat(hexNumber & 0x0000ff) / 255
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        }
        return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
    }
}


extension Color {

    struct Palette {
        let name: String

        var mainBackground: Color {
            Color("background-main")
        }

        var midBackground: Color {
            Color("background-mid")
        }

        var alternativeBackground: Color {
            Color("background-alt")
        }

        var primaryText: Color {
            Color("text-primary")
        }

        var alternativeText: Color {
            Color("text-alt")
        }

        var primary: Color {
            Color("primary")
        }

        var secondary: Color {
            Color("secondary")
        }

        var tertiary: Color {
            Color("tertiary")
        }

        var quaternary: Color {
            Color("quaternary")
        }
    }

    static let palette = Palette(name: "main")
}


struct Theme {
    var mainBackground: Color {
        Color("background-main")
    }

    var midBackground: Color {
        Color("background-mid")
    }

    var alternativeBackground: Color {
        Color("background-alt")
    }

    var primaryText: Color {
        Color.fromHexString("#223E6D")
    }

    var alternativeText: Color {
        Color.fromHexString("#92A5C6")
    }

    var primary: Color {
        Color("primary")
    }

    var secondary: Color {
        Color("secondary")
    }

    var tertiary: Color {
        Color("tertiary")
    }

    var quaternary: Color {
        Color.fromHexString("#ADE6FE")
    }
}


struct FacebookTheme {
    var mainBackground: Color {
        Color("facebookBackground-main")
    }

    var midBackground: Color {
        Color("facebookBackground-mid")
    }

    var alternativeBackground: Color {
        Color("facebookBackground-alt")
    }

    var primaryText: Color {
        Color("facebookText-primary")
    }

    var alternativeText: Color {
        Color("facebookText-alt")
    }

    var primary: Color {
        Color("facebookPrimary")
    }

    var secondary: Color {
        Color("facebookSecondary")
    }

    var tertiary: Color {
        Color("facebookTertiary")
    }

    var quaternary: Color {
        Color("facebookQuaternary")
    }
}
