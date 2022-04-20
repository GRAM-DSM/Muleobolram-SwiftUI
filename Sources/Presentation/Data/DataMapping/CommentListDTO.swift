import Foundation

// MARK: DTO
struct CommentListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "comment_join"
    }
    let list: [CommentDTO]
}

// MARK: toDomain
extension CommentListDTO {
    func toDomain() -> [Comment] {
        return list.map { $0.toDomain() }
    }
}
