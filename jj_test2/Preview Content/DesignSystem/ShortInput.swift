//
//  ShortInput.swift
//  jj_test2
//
//  Created by John Keefe on 7/14/25.
//

import SwiftUI

struct ShortInput: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField("", text: $text)
            .padding()
            .background(
                ZStack {
                    Color.clear.background(.ultraThinMaterial)
                    Color(hex: "332D3D").opacity(0.1)
                }
            )
            .cornerRadius(12)
            .font(.system(size: 16))
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
            )
            .overlay(
                // 👇 This puts the placeholder above everything else inside the same visual frame
                Group {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(Color(hex: "CDCDCD"))
                            .padding(.leading, 16)
                            .padding(.vertical, 2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            )
            .padding(.horizontal, 40)
    }
}

