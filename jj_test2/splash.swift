import SwiftUI

let messageTexts = [
    "You're amazing!",
    "Loved your idea today.",
    "Keep going 💪",
    "You made me smile!",
    "Thanks for being you.",
    "Crushed it on that project!",
    "You're amazing!",
    "Loved your idea today.",
    "Keep going 💪",
    "You made me smile!",
    "Thanks for being you.",
    "Crushed it on that project!"
]

struct SplashView: View {
    @Binding var flow: AppFlow

    struct FloatingMessage: View {
        let text: String
        let baseX: CGFloat
        let baseY: CGFloat

        @State private var offsetX: CGFloat = 0
        @State private var offsetY: CGFloat = 0

        var body: some View {
            Text(text)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color(hex: "#132B64"))
                .foregroundColor(Color(hex: "#FFF"))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "#FFF"), lineWidth: 2)
                )
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
                .offset(x: baseX + offsetX, y: baseY + offsetY)
                .onAppear {
                    animate()
                }
        }

        private func animate() {
            withAnimation(
                Animation.easeInOut(duration: Double.random(in: 3...5))
                    .repeatForever(autoreverses: true)
            ) {
                offsetX = CGFloat.random(in: -12...12)
                offsetY = CGFloat.random(in: -10...10)
            }
        }
    }

    var body: some View {
        ZStack {
            bgSplash()

            VStack {
                VStack(spacing: 12) {
                    Image("bLogo")
                        .resizable()
                        .padding(.top, 80)
                        .scaledToFit()
                        .frame(width: 313, height: 249.34)

                    ZStack {
                        ForEach(0..<12, id: \.self) { i in
                            let baseX = CGFloat.random(in: -150...150)
                            let baseY = CGFloat.random(in: -60...110)
                            FloatingMessage(text: messageTexts[i], baseX: baseX, baseY: baseY)
                        }
                    }
                    .frame(width: 300, height: 200)
                    .frame(height: 180)
                    .padding(.top, 16)

                    Text("Spread Kindness").style(.title)
                        .padding(.top, 64)

                    Text("Send anonymous compliments to brighten someone's day").style(.body)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                }
                .frame(maxHeight: .infinity)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 24)

                VStack(spacing: 20) {
                    HStack {
                        Text("+1")
                            .frame(width: 60)
                            .padding()
                            .background(Color.black.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                        Text("(603)320-9772")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 40)
                    
                    ctaButton(title: "Log in / Sign up") {
                        flow = .contacts // or whichever view you want to navigate to
                    }
                    .padding(.bottom, 64)
                }
            }
        }
    }
}

#Preview {
    SplashView(flow: .constant(.splash))
}
