//
//  NewIOSAppApp.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import SwiftUI

@main
struct NewIOSAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .background(Colors.background)
        }
    }
}


enum Theme: String {
    case device
    case light
    case dark
}

extension Theme {
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .device:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

extension UserDefaults {
    var theme: Theme {
        get {
            guard let themeRawValue = string(forKey: "theme"),
                  let theme = Theme(rawValue: themeRawValue) else {
                return .device
            }
            return theme
        }
        set {
            set(newValue.rawValue, forKey: "theme")
        }
    }
}

struct ThemeColorScheme: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    let theme: Theme

    func body(content: Content) -> some View {
        let preferredColorScheme: ColorScheme?
        if theme.userInterfaceStyle == .unspecified {
            preferredColorScheme = nil
        } else {
            preferredColorScheme = theme.userInterfaceStyle == .light ? .light : .dark
        }
        return content.preferredColorScheme(preferredColorScheme)
    }
}

extension View {
    func themeColorScheme(for theme: Theme) -> some View {
        self.modifier(ThemeColorScheme(theme: theme))
    }
}

