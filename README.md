# ios-shared

Shared Swift Package libraries used across Faraaz Sareshwala's iOS apps (`Forecash`, `Clean Dial`,
and `Montage`).

## Libraries

### `OtherApps`

Provides a single source of truth (`DeveloperAppsCatalog`, `DeveloperAppInfo`) and SwiftUI section
rows (`OtherAppsView`) with bundled app icons (`Assets.xcassets`) to cross-promote other apps from
the developer without duplicating metadata or icon assets across repositories.

- **Minimum iOS version:** iOS 15.0+
- **Zero network requests:** All metadata and icons are bundled offline inside the Swift Package.
- **Automatic self-exclusion:** Excludes the running host app via `Bundle.main.bundleIdentifier`.
- **Unreleased placeholder guard:** Entries with `appStoreURL == nil` are hidden until their App
  Store URL is added.

#### Usage

```swift
import OtherApps
import SwiftUI

Form {
  Section("Other Apps from the Developer") {
    OtherAppsView()
  }
}
```

With an optional tap handler (e.g. for analytics):

```swift
Section("Other Apps from the Developer") {
  OtherAppsView { app in
    analytics.logTap(app.appName)
  }
}
```

## Adding or Updating an App

1. Add the app's `.imageset` to `Sources/OtherApps/Resources/Assets.xcassets/`.
2. Add or update its `DeveloperAppInfo` entry in `Sources/OtherApps/DeveloperAppsCatalog.swift`.
3. Run tests and tag a new SemVer release (e.g., `1.1.0`).
4. In each consumer Xcode project, run **File → Packages → Update to Latest Package Versions**.
