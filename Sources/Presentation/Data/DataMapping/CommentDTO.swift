import Foundation

// MARK: DTO
struct CommentDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case writer = "user_id"
        case content
    }
    let writer: String
    let content: String
}

// MARK: toDomain
extension CommentDTO {
    func toDomain() -> Comment {
        return .init(
            writer: writer,
            content: content
        )
    }
}
