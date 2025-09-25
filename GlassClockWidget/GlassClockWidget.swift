import WidgetKit
import SwiftUI

struct GlassClockEntry: TimelineEntry {
    let date: Date
}

struct GlassClockProvider: TimelineProvider {
    func placeholder(in context: Context) -> GlassClockEntry {
        GlassClockEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (GlassClockEntry) -> Void) {
        completion(GlassClockEntry(date: Date()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<GlassClockEntry>) -> Void) {
        var entries: [GlassClockEntry] = []
        let currentDate = Date()
        for minuteOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            entries.append(GlassClockEntry(date: entryDate))
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct GlassClockEntryView: View {
    var entry: GlassClockEntry
    @ObservedObject var settings = SettingsManager.shared
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .cornerRadius(20)
            
            VStack {
                Text(formattedTime(entry.date))
                    .font(.system(size: 50, weight: fontWeight(), design: .rounded))
                    .foregroundColor(settings.clockColor.opacity(0.9))
                    .shadow(radius: 5)
                
                Text(entry.date, style: .date)
                    .font(.headline)
                    .foregroundColor(settings.clockColor.opacity(0.7))
            }
        }
        .padding()
    }
    
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = settings.is24Hour ? "HH:mm" : "hh:mm a"
        return formatter.string(from: date)
    }
    
    private func fontWeight() -> Font.Weight {
        switch settings.fontWeight {
        case "thin": return .thin
        case "bold": return .bold
        default: return .regular
        }
    }
}

struct GlassClockWidget: Widget {
    let kind: String = "GlassClockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: GlassClockProvider()) { entry in
            GlassClockEntryView(entry: entry)
        }
        .configurationDisplayName("Glass Clock")
        .description("Lockscreen-style glass clock for your Home Screen.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct GlassClockWidget_Previews: PreviewProvider {
    static var previews: some View {
        GlassClockEntryView(entry: GlassClockEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
