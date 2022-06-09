import Foundation

struct CommunityDetailDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case userId = "user_id"
    }
    let id: Int
    let title: String
    let content: String
    let userId: Int
}

extension CommunityDetailDTO {
    func toDomain() -> CommunityDetail {
        return .init(
            id: id,
            title: title,
            content: content,
            userId: userId
        )
    }
}
