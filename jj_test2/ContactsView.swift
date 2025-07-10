import SwiftUI

struct ContactsView: View {
    @Binding var flow: AppFlow
    @State private var searchText = ""

    var body: some View {
        ZStack {
            Color(hex: "#21077D").ignoresSafeArea()

            VStack(spacing: 0) {
                // 🔺 Top Nav
                HStack {
                    Button(action: {
                        withAnimation {
                            flow = .splash
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
                .padding(.top, 60) // Safe area spacing
                .padding(.bottom, 20)

                Spacer()

                // 🔍 Search & Manual Entry Section
                VStack(spacing: 16) {
                    TextField("", text: $searchText)
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .placeholder(when: searchText.isEmpty) {
                            Text("Search contacts...")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 16)
                        }

                    Button(action: {
                        flow = .content
                    }) {
                        Text("Enter Number Manually")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#F00C91"))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                }
                .padding(.horizontal, 40)

                Divider()
                    .background(Color.white.opacity(0.2))
                    .padding(.vertical, 32)
                    .padding(.horizontal, 40)

                // 🧑‍🤝‍🧑 Recent Contacts Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Recent contacts")
                        .foregroundColor(.white)
                        .fontWeight(.bold)

                    VStack(spacing: 16) {
                        ContactCard(name: "Monkey D. Luffy", number: "+1 (585) 973-4392", imageName: "VD_avatar-1") {
                            flow = .content
                        }
                        ContactCard(name: "Roronoa Zoro", number: "+1 (585) 973-4392", imageName: "VD_avatar-2")
                        ContactCard(name: "Nami Bell-mère", number: "+1 (585) 973-4392", imageName: "VD_avatar-3")
                        ContactCard(name: "Soga King", number: "+1 (585) 973-4392", imageName: "VD_avatar-4")
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
    }
}

// Contact Card Component
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
            }
            .padding()
            .background(Color.black.opacity(0.6))
            .cornerRadius(16)
        }
    }
}

// Placeholder modifier
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

// Preview
#Preview {
    ContactsView(flow: .constant(.contacts))
}
