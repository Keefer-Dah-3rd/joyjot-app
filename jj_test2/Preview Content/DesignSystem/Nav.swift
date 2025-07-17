//
//  Nav.swift
//  jj_test2
//
//  Created by John Keefe on 7/11/25.
//

import SwiftUI


struct NavHeader: View {
    @Binding var flow: AppFlow
    var backTarget: AppFlow

    var body: some View {
        HStack {
            Button(action: {
                flow = backTarget
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.logoBlue)
            }

            Spacer()

            Image(systemName: "person.fill")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.logoBlue)
        }
        .padding(.top, 4)
        .padding(.horizontal, 40) // Adds 40pt padding inside the bar
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity) // Ensures HStack fills width
        .background(Color.clear) // Optional: gives it structure
    }
}
