import Foundation

// MARK: DTO
struct CommunityDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "id_pk"
        case name
        case title
        case content
        case created = "created_at"
    }
    let id: Int
    let name: String
    let title: String
    let content: String
    let created: String
}

// MARK: toDomain
extension CommunityDTO {
    func toDomain() -> Community {
        return .init(
            id: id,
            name: name,
            title: title
        )
    }
}
