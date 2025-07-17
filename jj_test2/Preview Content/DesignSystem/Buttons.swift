//
//  Buttons.swift
//  jj_test2
//
//  Created by John Keefe on 7/11/25.
//

import SwiftUI

struct ctaButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.logoBlue)
                .cornerRadius(16)
        }
        .padding(.horizontal, 40) // Apply 40pt padding on left and right
    }
}
