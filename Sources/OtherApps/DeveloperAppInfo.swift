import Foundation
import SwiftUI
import UIKit

/// Metadata describing an iOS app published by the developer.
public struct DeveloperAppInfo: Identifiable, Equatable, Hashable, Sendable {
  public let id: String
  public let bundleIdentifier: String
  public let iconName: String
  public let appName: String
  public let description: String
  public let appStoreURL: URL?

  /// Indicates whether the app has a published App Store URL ready for cross-promotion.
  public var isPublished: Bool {
    if appStoreURL != nil {
      return true
    } else {
      return false
    }
  }

  public init(
    id: String,
    bundleIdentifier: String,
    iconName: String,
    appName: String,
    description: String,
    appStoreURL: URL?
  ) {
    self.id = id
    self.bundleIdentifier = bundleIdentifier
    self.iconName = iconName
    self.appName = appName
    self.description = description
    self.appStoreURL = appStoreURL
  }

  /// SwiftUI image loaded from the `OtherApps` package resource bundle.
  public var iconImage: Image {
    Image(iconName, bundle: .module)
  }

  /// UIKit image loaded from the `OtherApps` package resource bundle.
  public var iconUIImage: UIImage? {
    UIImage(named: iconName, in: .module, compatibleWith: nil)
  }
}
