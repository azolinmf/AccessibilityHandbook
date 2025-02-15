//
//  SearchView.swift
//  Accessibility Handbook
//
//  Created by Giovani Nascimento Pereira on 28/10/22.
//

import SwiftUI

struct SearchView: View {
  @Binding var text: String

  var body: some View {
    searchView
  }
}

private extension SearchView {
  var allPages: [Page] { AllPagesProvider().allPages }

  var filteredContent: [Page] {
    allPages.filter { $0.title.lowercased().contains(text.lowercased()) }
  }

  @ViewBuilder
  var searchView: some View {
    if filteredContent.isEmpty {
      emptyContent
    } else {
      searchedContent
    }
  }

  var emptyContent: some View {
    VStack(spacing: .regular) {
      VerticalSpace(100.0)
      Asset.emptySearch.swiftUIImage
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 250.0)
        .accessibilityHidden(true)
      Title(L10n.Search.Empty.title)
      Text(L10n.Search.Empty.message)
      Spacer()
    }
  }

  var searchedContent: some View {
    VStack(alignment: .leading, spacing: .regular) {
      ForEach(filteredContent, id: \.id) { page in
        NavigationLink {
          page.page
        } label: {
          let icon: Image? = {
            switch page {
            case is GamePage:
              return Icon.gameController
            default:
              return nil
            }
          }()
          IndexCell(title: page.title, icon: icon)
        }
      }
    }
  }
}
