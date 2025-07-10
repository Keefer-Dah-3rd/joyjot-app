import SwiftUI

struct ContentView: View {
    @Binding var flow: AppFlow

    @State private var isOpen = false
    @State private var jump = false
    @State private var bounce = false

    var body: some View {
        ZStack {
            Color(hex: "#21077D")
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // 🔺 Top Nav
                HStack {
                    Button(action: {
                        withAnimation {
                            flow = .contacts
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
                    CloudLayer(color: Color(hex: "#2A003A"), ellipseCount: 50, offsetY: 260)

                    Image(isOpen ? "mail_open" : "mail")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 260)
                        .offset(y: jump ? -80 : 60)
                        .animation(.interpolatingSpring(stiffness: 150, damping: 10), value: jump)
                        .animation(.easeInOut(duration: 0.3), value: isOpen)
                        .onTapGesture {
                            jump = true
                            isOpen = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                                jump = false
                                withAnimation {
                                    flow = .sent
                                }
                            }
                        }

                    CloudLayer(color: Color(hex: "#42005C"), ellipseCount: 50, offsetY: 320)
                    CloudLayer(color: Color(hex: "#F00C91"), ellipseCount: 80, offsetY: 440)
                }

                Spacer()

                VStack(spacing: 8) {
                    if !isOpen {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .offset(y: bounce ? -10 : 0)
                            .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: bounce)
                            .onAppear {
                                bounce = true
                            }
                    }

                    Text("Pen a Jot")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .padding(.bottom, 40)
                }
            }
        }
    }
}

struct CloudLayer: View {
    let color: Color
    let ellipseCount: Int
    let offsetY: CGFloat

    var body: some View {
        ZStack {
            ForEach(0..<ellipseCount, id: \.self) { _ in
                let baseX = CGFloat.random(in: -200...200)
                let baseY = CGFloat.random(in: -100...0)

                AnimatedEllipse(color: color, baseX: baseX, baseY: baseY)
                    .frame(width: CGFloat.random(in: 80...140), height: CGFloat.random(in: 80...140))
            }
        }
        .offset(y: offsetY) // <- this now correctly belongs to the ZStack
    }
}

struct AnimatedEllipse: View {
    let color: Color
    let baseX: CGFloat
    let baseY: CGFloat
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0

    var body: some View {
        Ellipse()
            .fill(color)
            .offset(x: baseX + offsetX, y: baseY + offsetY)
            .onAppear { animate() }
    }

    private func animate() {
        withAnimation(Animation.easeInOut(duration: Double.random(in: 3...6)).repeatForever(autoreverses: true)) {
            offsetX = CGFloat.random(in: -100...100)
            offsetY = CGFloat.random(in: -100...100)
        }
    }
}

#Preview {
    ContentView(flow: .constant(.content))
}
