//
//  BgSplash.swift
//  jj_test2
//
//  Created by John Keefe on 7/11/25.
//

import SwiftUI

struct bgSplash: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: .grad1_1, location: 0.0),
                .init(color: .grad1_2, location: 0.77),
                .init(color: .grad1_3, location: 1.0)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()  // moves the background over the notch and bar at the bottom
    }
}
