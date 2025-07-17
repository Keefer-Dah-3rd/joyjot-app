//
//  Typography.swift
//  jj_test2
//
//  Created by John Keefe on 7/11/25.
//

import SwiftUI

// MARK: - Color Extension (your design colors)
extension Color {
    static let lBlue = Color.logoBlue
    static let White = Color.white
    static let gray = Color.gray // Adjust as needed
}

// MARK: - JoyJot Text Styles
enum JoyJotTextStyle {
    case title
    case subtitle
    case body
    case caption
    
    var font: Font {
        switch self {
        case .title: return .system(size: 32, weight: .bold)
        case .subtitle: return .system(size: 20, weight: .semibold)
        case .body: return .system(size: 16, weight: .regular)
        case .caption: return .system(size: 14, weight: .light)
        }
    }
    
    var color: Color {
        switch self {
        case .title: return .lBlue
        case .subtitle: return .White
        case .body: return .White
        case .caption: return .gray
        }
    }
}

// MARK: - Text Extension for Easy Styling
extension Text {
    func style(_ style: JoyJotTextStyle) -> some View {
        self
            .font(style.font)
            .foregroundColor(style.color)
            .fixedSize(horizontal: false, vertical: true) // Ensures proper wrapping
            .multilineTextAlignment(.center) // Optional: Adjust as needed
    }
}

