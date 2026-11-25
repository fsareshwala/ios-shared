import Foundation
import SwiftUI
import Testing
import UIKit

@testable import OtherApps

@Suite("OtherApps Catalog and View")
struct OtherAppsTests {
  @Test("Catalog entries have unique identifiers, bundle IDs, clean copy, and bundled icons")
  func catalogMetadataAndIconsAreValid() {
    let apps = DeveloperAppsCatalog.all
    #expect(apps.count == 3)

    let uniqueIDs = Set(apps.map(\.id))
    let uniqueBundleIDs = Set(apps.map(\.bundleIdentifier))
    #expect(uniqueIDs.count == apps.count)
    #expect(uniqueBundleIDs.count == apps.count)

    for app in apps {
      #expect(!app.id.isEmpty)
      #expect(!app.bundleIdentifier.isEmpty)
      #expect(!app.appName.isEmpty)
      #expect(!app.description.isEmpty)
      #expect(!app.appName.contains("&"))
      #expect(!app.description.contains("&"))
      #expect(!app.description.localizedCaseInsensitiveContains("outing"))
      #expect(app.iconUIImage != nil, "Missing bundled icon asset: \(app.iconName)")

      if let url = app.appStoreURL {
        #expect(url.scheme == "https")
        #expect(url.host == "apps.apple.com")
      }
    }
  }

  @Test("otherApps excludes the host app and unpublished placeholders by default")
  func otherAppsFiltering() {
    let forMontage = DeveloperAppsCatalog.otherApps(
      excluding: DeveloperAppInfo.montage.bundleIdentifier
    )
    #expect(forMontage == [.forecash, .cleanDial])

    let forCleanDial = DeveloperAppsCatalog.otherApps(
      excluding: DeveloperAppInfo.cleanDial.bundleIdentifier
    )
    #expect(forCleanDial == [.forecash])

    let forForecash = DeveloperAppsCatalog.otherApps(
      excluding: DeveloperAppInfo.forecash.bundleIdentifier
    )
    #expect(forForecash == [.cleanDial])

    let forCleanDialIncludingUnreleased = DeveloperAppsCatalog.otherApps(
      excluding: DeveloperAppInfo.cleanDial.bundleIdentifier,
      includeUnreleased: true
    )
    #expect(forCleanDialIncludingUnreleased == [.forecash, .montage])
  }

  @Test("OtherAppsView hosts cleanly in UIHostingController")
  @MainActor
  func otherAppsViewHostsSafely() {
    let view = Form {
      Section("Other Apps from the Developer") {
        OtherAppsView(excluding: DeveloperAppInfo.montage.bundleIdentifier)
      }
    }
    let controller = UIHostingController(rootView: view)
    controller.loadViewIfNeeded()
    let fittedSize = controller.sizeThatFits(in: CGSize(width: 390, height: 400))
    #expect(fittedSize.width > 0)
    #expect(fittedSize.height > 0)
  }
}
