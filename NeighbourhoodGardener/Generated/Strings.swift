// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Alert {
    internal enum Error {
      /// OK
      internal static let confirmation = L10n.tr("NeighbourhoodGardener", "ALERT.ERROR.CONFIRMATION")
      /// Please contact us if the problem persists.
      internal static let message = L10n.tr("NeighbourhoodGardener", "ALERT.ERROR.MESSAGE")
      /// Something went wrong
      internal static let title = L10n.tr("NeighbourhoodGardener", "ALERT.ERROR.TITLE")
    }
  }

  internal enum Home {
    /// My Neighbourhood Garden
    internal static let header = L10n.tr("NeighbourhoodGardener", "HOME.HEADER")
  }

  internal enum Listing {
    /// New Listing
    internal static let new = L10n.tr("NeighbourhoodGardener", "LISTING.NEW")
  }

  internal enum Produce {
    /// for sale by %@
    internal static func soldBy(_ p1: Any) -> String {
      return L10n.tr("NeighbourhoodGardener", "PRODUCE.SOLD_BY", String(describing: p1))
    }
  }

  internal enum Tab {
    /// Account
    internal static let account = L10n.tr("NeighbourhoodGardener", "TAB.ACCOUNT")
    /// Home
    internal static let home = L10n.tr("NeighbourhoodGardener", "TAB.HOME")
    /// My Garden
    internal static let listings = L10n.tr("NeighbourhoodGardener", "TAB.LISTINGS")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
