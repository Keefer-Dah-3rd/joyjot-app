import SwiftUI

struct ContactsView: View {
    @Binding var flow: AppFlow
    @State private var searchText = ""
    @State private var selectedTab = "Recent"

    var body: some View {
        ZStack(alignment: .top) {
            Color.bg1.ignoresSafeArea()

            VStack(spacing: 0) {
                // 🔹 Sticky Header
                VStack(spacing: 16) {
                    NavHeader(flow: $flow, backTarget: .splash)

                    // Search field
                    ShortInput(placeholder: "Search contacts", text: $searchText)

                    // CTA row
                    HStack {
                        ctaButton(title: "Enter Number Manually") {
                            flow = .content
                        }
                    }
                    
                }
                .padding(.top, 20)
                .padding(.bottom, 40)
                .zIndex(1)

                // 🔷 Scrollable Contact Section with Blue Background
                GeometryReader { geometry in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            // Tab headers
                            HStack {
                                Text("Recent contacts")
                                    .style(.subtitle)
                                Spacer()
                                Text("Favorites")
                                    .style(.caption)
                                    .opacity(0.5)
                            }
                            .padding(.top, 24)

                            // Contacts
                            VStack(spacing: 12) {
                                ForEach(sampleContacts) { contact in
                                    ContactCard(
                                        name: contact.name,
                                        number: contact.number,
                                        imageName: contact.imageName
                                    ) {
                                        flow = .content
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 120)
                        .padding(.top, 24)
                        .frame(minHeight: geometry.size.height) // ensure full height scroll
                        .background(
                            Color(hex: "#132B64")
                                .ignoresSafeArea()
                        )
                        .cornerRadius(30, corners: [.topLeft, .topRight])
                    }
                }
            }
        }
    }
}

// MARK: - Contact Card
struct ContactCard: View {
    let name: String
    let number: String
    let imageName: String
    var onTap: (() -> Void)? = nil

    var body: some View {
        Button(action: {
            onTap?()
        }) {
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())

                VStack(alignment: .leading) {
                    Text(name)
                        .foregroundColor(.white)
                        .bold()
                    Text(number)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }

                Spacer()

                Image(systemName: "ellipsis")
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.black.opacity(0.6))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.2), lineWidth: 2)
            )
        }
    }
}


// MARK: - Sample Data
struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let number: String
    let imageName: String
}

let sampleContacts: [Contact] = [
    .init(name: "Monkey D. Luffy", number: "+1 (585) 973-4392", imageName: "VD_avatar-1"),
    .init(name: "Roronoa Zoro", number: "+1 (585) 973-4392", imageName: "VD_avatar-2"),
    .init(name: "Nami Bell-mère", number: "+1 (585) 973-4392", imageName: "VD_avatar-3"),
    .init(name: "Soga King", number: "+1 (585) 973-4392", imageName: "VD_avatar-4"),
    .init(name: "Vinsmoke Sanji", number: "+1 (585) 973-4392", imageName: "VD_avatar-5"),
    .init(name: "Tony Tony Chopper", number: "+1 (585) 973-4392", imageName: "VD_avatar-6")
]

// MARK: - Corner Radius Extension
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview
#Preview {
    ContactsView(flow: .constant(.contacts))
}
