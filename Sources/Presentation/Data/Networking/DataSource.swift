import Foundation

import Combine
import Moya

final class DataSource: MoyaProvider<RestAPI> {

    static let shared = DataSource()

    private init() { }

    // auth
    func login(
        _ id: String,
        _ password: String
    ) -> Future<TokenDTO, NetworkingError> {
        return Future<TokenDTO, NetworkingError> {_ in
            self.requestPublisher(.login(
                id: id,
                password: password
            )).map(TokenDTO.self)
                .mapError { NetworkingError($0) }
        }
    }

    func signup(
        _ id: String,
        _ passsword: String,
        _ name: String
    ) -> Future<Void, NetworkingError> {
        return requestVoidPublisher(.signup(
            id: id,
            password: passsword,
            name: name
        ))
    }

    func checkId(
        _ id: String
    ) -> Future<Void, NetworkingError> {
        return requestVoidPublisher(.checkId(id: id))
    }

    // community
    func postCommunity(
        _ title: String,
        _ content: String
    ) -> Future<Void, NetworkingError> {
        return requestVoidPublisher(.postCommunity(
            title: title,
            content: content
        ))
    }

    func deleteCommunity(_ postId: Int) -> Future<Void, NetworkingError> {
        return requestVoidPublisher(.deleteCommunity(postId: postId))
    }

    func fetchCommunity() -> AnyPublisher<[Community], NetworkingError> {
        return requestPublisher(.fetchCommunity, CommunityListDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }

    // comment
    func postComment(
        _ postId: Int,
        _ content: String
    ) -> Future<Void, NetworkingError> {
        return requestVoidPublisher(.postComment(
            postId: postId,
            content: content
        ))
    }

    func fetchComment(_ postId: Int) -> AnyPublisher<[Comment], NetworkingError> {
        return requestPublisher(.fetchComment(postId: postId), CommentListDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
