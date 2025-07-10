//
//  SentView.swift
//  jj_test2
//
//  Created by John Keefe on 6/28/25.
//

import SwiftUI

struct SentView: View {
    @Binding var flow: AppFlow

    @State private var sway = false
    
    var body: some View {
        ZStack {
            Color(hex: "#21077D")
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Nav
                HStack {
                    Button(action: {
                        withAnimation {
                            flow = .content
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color(hex: "#F00C91"))
                            .font(.title2)
                    }
                    Spacer()
                    Image(systemName: "person.fill")
                        .foregroundColor(Color(hex: "#F00C91"))
                        .font(.title2)
                }
                .padding(.horizontal, 40)
                .padding(.top, 60)
                .padding(.bottom, 20)

                Spacer()

                ZStack {
                    // Clouds dakest color
                    SmallCloudCluster(color: Color(hex: "#2A003A"), position: CGPoint(x: 290, y: 65))
                    SmallCloudCluster(color: Color(hex: "#2A003A"), position: CGPoint(x: 200, y: 190))
                    
                    ZStack {
                        // Speed lines
                        VStack(spacing: 6) {
                            Rectangle()
                                .fill(Color.white.opacity(0.8))
                                .frame(width: 30, height: 3)
                            Rectangle()
                                .fill(Color.white.opacity(0.8))
                                .frame(width: 20, height: 3)
                            Rectangle()
                                .fill(Color.white.opacity(0.8))
                                .frame(width: 10, height: 3)
                        }
                        .offset(x: sway ? -45 : -55, y: -5) // Positioned to the left of envelope
                        .opacity(0.8)

                        // Envelope
                        Image("mail")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                    }
                    .offset(x: sway ? -10 : 10) // Envelope sway movement
                    .rotationEffect(.degrees(sway ? -2 : 2)) // Slight tilt for effect
                    .animation(
                        .easeInOut(duration: 1.5).repeatForever(autoreverses: true),
                        value: sway
                    )
                    .onAppear {
                        sway = true
                    }

                    // Clouds mid color
                    SmallCloudCluster(color: Color(hex: "#42005C"), position: CGPoint(x: 240, y: -50))
                    SmallCloudCluster(color: Color(hex: "#42005C"), position: CGPoint(x: 130, y: 240))
                        
                    //Clouds brightist color
                    SmallCloudCluster(color: Color(hex: "#F00C91"), position: CGPoint(x: 85, y: 5))
                    SmallCloudCluster(color: Color(hex: "#F00C91"), position: CGPoint(x: 320, y: 220))
                }
                .frame(height: 200)

                Spacer()

                VStack(spacing: 4) {
                    Text("Jot On Route")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(Color(hex: "#F00C91"))

                    Text("Your message is being sent to")
                        .font(.system(size: 18))
                        .foregroundColor(.white)

                    Text("Monkey D. Luffy")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 40)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40)

                Button(action: {
                    withAnimation {
                        flow = .splash
                    }
                }) {
                    Text("Go back to the beginning")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#F00C91"))
                        .cornerRadius(100)
                        .padding(.horizontal, 40)
                }

                Text("There is nothing left this demo, fuck off and send another compliment")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.4))
                    .padding(.top, 20)
                    .padding(.horizontal, 40)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct SmallCloudCluster: View {
    let color: Color
    let position: CGPoint

    @State private var blobs: [CloudBlob] = (0..<10).map { _ in CloudBlob() }
    @State private var animate = false

    var body: some View {
        ZStack {
            ForEach(blobs) { blob in
                Ellipse()
                    .fill(color)
                    .frame(width: blob.width, height: blob.height)
                    .offset(
                        x: blob.initialX + (animate ? blob.xOffset : -blob.xOffset),
                        y: blob.initialY + (animate ? blob.yOffset : -blob.yOffset)
                    )
                    .animation(
                        .easeInOut(duration: Double.random(in: 2.5...4.0)).repeatForever(autoreverses: true),
                        value: animate
                    )
            }
        }
        .position(position)
        .onAppear {
            animate = true
        }
    }
}

struct CloudBlob: Identifiable {
    let id = UUID()
    let xOffset: CGFloat = .random(in: -4...4) // subtle animation wiggle
    let yOffset: CGFloat = .random(in: -4...4)

    let width: CGFloat = .random(in: 50...70)
    let height: CGFloat = .random(in: 50...70)

    // new: spawn position (relative to center)
    let initialX: CGFloat = .random(in: -65...65)
    let initialY: CGFloat = .random(in: -30...30)
}
// Preview
#Preview {
    SentView(flow: .constant(.contacts))
}
