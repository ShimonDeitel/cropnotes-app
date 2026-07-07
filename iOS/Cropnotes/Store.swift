import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    static let freeLimit = 8

    @Published var items: [VarietyNote] = []
    @Published var isPro: Bool = false

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("cropnotes_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: VarietyNote) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: VarietyNote) {
        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            items[idx] = item
            save()
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: VarietyNote) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([VarietyNote].self, from: data) else {
            items = Store.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static func seedData() -> [VarietyNote] {
        [
        VarietyNote(date: Date().addingTimeInterval(-86400), variety: "Cherokee Purple", crop: "Tomato", rating: "5"),
        VarietyNote(date: Date().addingTimeInterval(-172800), variety: "Detroit Dark Red", crop: "Beet", rating: "4"),
        VarietyNote(date: Date().addingTimeInterval(-259200), variety: "Genovese", crop: "Basil", rating: "5")
        ]
    }
}
