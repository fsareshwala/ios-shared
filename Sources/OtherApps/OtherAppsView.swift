import SwiftUI

/// Showcases other apps from the developer inside a SwiftUI `Form` or `List` section.
///
/// Automatically excludes the current host app using `Bundle.main.bundleIdentifier` and omits
/// apps without a published App Store URL unless `includeUnreleased` is enabled.
public struct OtherAppsView: View {
  @Environment(\.openURL) private var openURL

  public let apps: [DeveloperAppInfo]
  private let onAppTap: ((DeveloperAppInfo) -> Void)?

  public init(
    excluding bundleIdentifier: String? = Bundle.main.bundleIdentifier,
    includeUnreleased: Bool = false,
    onAppTap: ((DeveloperAppInfo) -> Void)? = nil
  ) {
    self.apps = DeveloperAppsCatalog.otherApps(
      excluding: bundleIdentifier,
      includeUnreleased: includeUnreleased
    )
    self.onAppTap = onAppTap
  }

  public init(
    apps: [DeveloperAppInfo],
    onAppTap: ((DeveloperAppInfo) -> Void)? = nil
  ) {
    self.apps = apps
    self.onAppTap = onAppTap
  }

  public var body: some View {
    ForEach(apps) { app in
      Button {
        onAppTap?(app)
        if let appStoreURL = app.appStoreURL {
          openURL(appStoreURL)
        }
      } label: {
        HStack(spacing: 15) {
          app.iconImage
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

          VStack(alignment: .leading, spacing: 4) {
            Text(app.appName)
              .font(.headline)

            Text(app.description)
              .font(.caption)
              .foregroundStyle(Color.secondary)
              .lineLimit(2)
          }
        }
      }
    }
  }
}

#Preview {
  Form {
    Section("Other Apps from the Developer") {
      OtherAppsView(excluding: nil, includeUnreleased: true)
    }
  }
}
