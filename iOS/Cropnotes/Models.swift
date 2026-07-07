import Foundation

struct VarietyNote: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var variety: String
    var crop: String
    var rating: String
}
