//
//  LongInput.swift
//  jj_test2
//
//  Created by John Keefe on 7/14/25.
//

import SwiftUI

struct LongInput: View {
    var placeholder: String
    @Binding var text: String
    let maxLength: Int = 540

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .topLeading) {
                // Blurred background with overlay color
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(hex: "332D3D")).opacity(0.1)
                    )
                    .frame(minHeight: 430)

                // Placeholder text
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color(hex: "CDCDCD"))
                        .padding(.horizontal, 15)
                        .padding(.top, 20)
                }

                // Editable text
                TextEditor(text: $text)
                    .padding(12)
                    .frame(minHeight: 160)
                    .foregroundColor(.white)
                    .opacity(text.isEmpty ? 0.85 : 1)
                    .scrollContentBackground(.hidden) // removes native background
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.5), lineWidth: 2)
                    )
                    .cornerRadius(12)
                    .onChange(of: text) { _, newValue in
                        if newValue.count > maxLength {
                            text = String(newValue.prefix(maxLength))
                        }
                    }
            }

            // Character counter
            HStack {
                Spacer()
                Text("\(text.count)/\(maxLength)")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 40)
    }
}
