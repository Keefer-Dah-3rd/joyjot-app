//
//  MainRouterView.swift
//  jj_test2
//
//  Created by John Keefe on 6/27/25.
//

import SwiftUI

enum AppFlow {
    case splash
    case contacts
    case content
    case coverdesign
    case messagefold
    case sent
}

struct MainRouterView: View {
    @State private var flow: AppFlow = .splash

    var body: some View {
        switch flow {
        case .splash:
            SplashView(flow: $flow)
        case .contacts:
            ContactsView(flow: $flow)
        case .content:
            ContentView(flow: $flow)
        case .coverdesign:
            CoverDesignView(flow: $flow)
        case .messagefold:
            MessageFoldView(flow: $flow)
        case .sent:
            SentView(flow: $flow)
        }
    }
}

#Preview {
    MainRouterView()
}
