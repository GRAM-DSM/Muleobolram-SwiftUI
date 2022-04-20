import Foundation

// MARK: DTO
struct CommunityListDTO: Decodable {
    let posts: [CommunityDTO]
}

// MARK: toDomain
extension CommunityListDTO {
    func toDomain() -> [Community] {
        return posts.map { $0.toDomain() }
    }
}
