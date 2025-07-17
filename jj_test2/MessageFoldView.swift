//
//  MessageFoldView.swift
//  jj_test2
//
//  Created by John Keefe on 7/14/25.
//

//
//  MessageFoldView.swift
//  jj_test2
//
//  Created by John Keefe on 7/14/25.
//

import SwiftUI

struct MessageFoldView: View {
    @Binding var flow: AppFlow
    @State private var showRightFold = false
    
    @State private var address = ""
    @State private var bodyLeft = ""
    @State private var bodyRight = ""
    @State private var endingStatement = ""
    @State private var signature = ""
    
    var body: some View {
        ZStack {
            Color.bg1.ignoresSafeArea() // Full background
            
            ScrollView {
                VStack(spacing: 20) {
                    NavHeader(flow: $flow, backTarget: .coverdesign)
                    
                    let designColors: [Color] = [
                        .blue, .pink, .purple, .green, .orange, .yellow,
                        .mint, .indigo, .red, .cyan, .teal, .brown
                    ]
                    
                    // Color Picker Section
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.1))
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
                    .padding([.horizontal, .bottom], 40)
                    
                    // Fold Toggle
                    HStack(spacing: 48) {
                        Button("Left fold") {
                            withAnimation { showRightFold = false }
                        }
                        .font(.system(size: 16, weight: showRightFold ? .regular : .bold))
                        .foregroundColor(.white)
                        .opacity(showRightFold ? 0.5 : 1)
                        
                        Divider()
                            .frame(width: 1, height: 50)
                            .background(Color(hex: "A9A9A9"))
                        
                        Button("Right fold") {
                            withAnimation { showRightFold = true }
                        }
                        .font(.system(size: 16, weight: showRightFold ? .bold : .regular))
                        .foregroundColor(.white)
                        .opacity(showRightFold ? 1 : 0.5)
                    }
                    
                    // Dynamic Content
                    ZStack {
                        if showRightFold {
                            rightFoldContent
                                .transition(.move(edge: .trailing))
                        } else {
                            leftFoldContent
                                .transition(.move(edge: .leading))
                        }
                    }
                    .animation(.easeInOut, value: showRightFold)
                }
                .padding(.bottom, 40) // Add breathing room at bottom
            }
        }
    }
    
    @ViewBuilder
    var leftFoldContent: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { geo in
                Image("card_background1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width - 20, height: geo.size.height)
                    .clipped()
                    .offset(x: 20)
            }

            VStack(spacing: 16) {
                ShortInput(placeholder: "Address", text: $address)
                LongInput(placeholder: "Body", text: $bodyLeft)
                ctaButton(title: "Send") {
                    flow = .sent
                }
            }
            .padding(.vertical, 32)
            .padding(.bottom, 68)
        }
        .cardCornerRadius(30, corners: [.topLeft, .bottomLeft])

    }
    
    @ViewBuilder
    var rightFoldContent: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { geo in
                Image("card_background1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width - 20, height: geo.size.height)
                    .clipped()
                    //.offset(x: -20) // shift left to pad image from the right
            }
            
            VStack(spacing: 16) {
                LongInput(placeholder: "Body", text: $bodyRight)
                ShortInput(placeholder: "Ending statement", text: $endingStatement)
                ShortInput(placeholder: "Signature", text: $signature)
                ctaButton(title: "Send") {
                    flow = .sent
                }
            }
            .padding(.vertical, 32)
        }
        .cardCornerRadius(30, corners: [.topRight, .bottomRight])
    }
}

struct MessageFoldView_Previews: PreviewProvider {
    static var previews: some View {
        MessageFoldView(flow: .constant(.messagefold))
            .preferredColorScheme(.dark)
    }
}
