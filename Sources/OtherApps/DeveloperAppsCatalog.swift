import Foundation

extension DeveloperAppInfo {
  public static let forecash = DeveloperAppInfo(
    id: "forecash",
    bundleIdentifier: "net.forecash",
    iconName: "forecash",
    appName: "Forecash",
    description:
      "Plan bill pay dates, forecast your finances. Project future balances so you can plan ahead.",
    appStoreURL: URL(string: "https://apps.apple.com/us/app/forecash-bill-planner/id6747775439")
  )

  public static let cleanDial = DeveloperAppInfo(
    id: "cleandial",
    bundleIdentifier: "com.fsareshwala.contactformatter",
    iconName: "cleandial",
    appName: "Clean Dial",
    description:
      "Format contact phone numbers into clean, consistent international or national formats.",
    appStoreURL: URL(string: "https://apps.apple.com/us/app/clean-dial/id6745625133")
  )

  // TODO: Set Montage's App Store URL once App Review approves it.
  public static let montage = DeveloperAppInfo(
    id: "montage",
    bundleIdentifier: "com.sareshwala.faraaz.montage",
    iconName: "montage",
    appName: "Montage",
    description:
      "Combine multiple video clips into a single seamless video, directly from the iOS Photos Share Sheet.",
    appStoreURL: nil
  )
}

/// Single source of truth for iOS apps published by the developer.
public enum DeveloperAppsCatalog {
  /// All developer apps in display order.
  public static let all: [DeveloperAppInfo] = [
    .forecash,
    .cleanDial,
    .montage,
  ]

  /// Returns other apps published by the developer, automatically excluding the running host app
  /// (matched by `bundleIdentifier`) and unpublished placeholder entries by default.
  public static func otherApps(
    excluding bundleIdentifier: String? = Bundle.main.bundleIdentifier,
    includeUnreleased: Bool = false
  ) -> [DeveloperAppInfo] {
    all.filter { app in
      if let bundleIdentifier, app.bundleIdentifier == bundleIdentifier {
        return false
      }

      if !includeUnreleased, !app.isPublished {
        return false
      }

      return true
    }
  }
}
