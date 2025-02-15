//
//  Accessibility_HandbookApp.swift
//  Accessibility Handbook
//
//  Created by Giovani Nascimento Pereira on 20/09/22.
//

import SwiftUI

@main
struct Accessibility_HandbookApp: App {
  @State private var isShowingDeeplink: Bool = false
  @State private var isPresentingDeeplink: Bool = false

  private let deeplinkHandler = DeeplinkHandler()

  var body: some Scene {
    WindowGroup {
      NavigationView {
        HomeView()
      }
      .navigationViewStyle(.stack)
      .onOpenURL { url in
        isPresentingDeeplink = deeplinkHandler.canOpen(url: url)
      }
      .sheet(isPresented: $isPresentingDeeplink, onDismiss: {
        isPresentingDeeplink = false
      }) {
        NavigationView {
          deeplinkHandler.deeplinkView()
        }
        .navigationViewStyle(.stack)
      }
    }
  }
}
