//
//  CoverDesignView.swift
//  jj_test2
//
//  Created by John Keefe on 7/14/25.
//

import SwiftUI

struct CoverDesignView: View {
    @Binding var flow: AppFlow
    @State private var selectedCoverIndex: Int? = nil

    let coverImageName = "card1" // This is the image name you provided

    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 6)

    var body: some View {
        ZStack {
            Color.bg1.ignoresSafeArea()

            VStack(spacing: 24) {
                // 🔹 Top Nav
                NavHeader(flow: $flow, backTarget: .content)

                // 📝 Title
                Text("Jot to Luffy").style(.title)

                // 🖼️ Cover image
                Image(coverImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140)
                    .shadow(radius: 10)

                // ➕ Add front cover image button
                Text("Add front cover image")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal, 40)

                // 🎨 Simulated Design Option Colors
                let designColors: [Color] = [
                    .blue, .pink, .purple, .green, .orange, .yellow,
                    .mint, .indigo, .red, .cyan, .teal, .brown
                ]

                // 🧁 Non-functional Design Buttons (6×2 Grid)
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.1)) // background container
                        .frame(height: 120)

                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 6),
                        spacing: 16
                    ) {
                        ForEach(0..<12) { i in
                            Circle()
                                .fill(designColors[i % designColors.count])
                                .frame(width: 40, height: 40)
                        }
                    }
                    .padding(16)
                }
                .padding(.horizontal, 40)

                Spacer()

                // 🟦 CTA Button
                ctaButton(title: "Design inside") {
                    flow = .messagefold // update with actual destination
                }
                .padding(.bottom, 40)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    CoverDesignView(flow: .constant(.coverdesign))
}
