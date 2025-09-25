import SwiftUI

struct ContentView: View {
    @ObservedObject var settings = SettingsManager.shared
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("24 Hour Format", isOn: $settings.is24Hour)
                
                Picker("Font Weight", selection: $settings.fontWeight) {
                    Text("Thin").tag("thin")
                    Text("Regular").tag("regular")
                    Text("Bold").tag("bold")
                }
                .pickerStyle(.segmented)
                
                ColorPicker("Clock Color", selection: $settings.clockColor)
            }
            .navigationTitle("GlassClock Settings")
        }
    }
}
