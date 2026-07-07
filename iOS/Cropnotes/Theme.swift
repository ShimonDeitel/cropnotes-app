import SwiftUI

enum Theme {
    static let background = Color(red: 0.106, green: 0.137, blue: 0.075)
    static let accent = Color(red: 0.561, green: 0.749, blue: 0.247)
    static let accent2 = Color(red: 0.839, green: 0.404, blue: 0.173)
    static let cardBackground = Color(.secondarySystemGroupedBackground)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
