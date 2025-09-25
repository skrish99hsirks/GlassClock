import SwiftUI

class SettingsManager: ObservableObject {
    static let suiteName = "group.com.yourname.glassclock"
    static let shared = SettingsManager()
    
    @AppStorage("is24Hour", store: UserDefaults(suiteName: suiteName)) var is24Hour: Bool = true
    @AppStorage("fontWeight", store: UserDefaults(suiteName: suiteName)) var fontWeight: String = "regular"
    @AppStorage("clockColor", store: UserDefaults(suiteName: suiteName)) var clockColor: Color = .white
}
