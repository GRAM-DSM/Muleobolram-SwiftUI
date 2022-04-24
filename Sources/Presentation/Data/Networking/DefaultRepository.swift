import Foundation

import Combine

final class DefaultRepository: Repository {

    private let dataSource = DataSource.shared
    private let keychainDataSource = KeychainDataSource.shared

    func login(
        _ id: String,
        _ password: String
    ) -> Future<Void, NetworkingError> {
        return Future<Void, NetworkingError> { _ in
            self.dataSource.login(id, password)
                .map { token -> Void in
                    self.keychainDataSource.registerAccessToken(token.accessToken)
                    self.keychainDataSource.registerRefreshToken(token.refreshToken)
                    return ()
                }.mapError { NetworkingError($0) }
        }
    }

    func signup(
        _ id: String,
        _ password: String,
        _ name: String
    ) -> Future<Void, NetworkingError> {
        return dataSource.signup(id, password, name)
    }

    func checkId(_ id: String) -> Future<Void, NetworkingError> {
        return dataSource.checkId(id)
    }

    func postCommunity(
        _ title: String,
        _ content: String
    ) -> Future<Void, NetworkingError> {
        return dataSource.postCommunity(title, content)
    }

    func fetchCommunity() -> AnyPublisher<[Community], NetworkingError> {
        return dataSource.fetchCommunity()
    }

    func deletCommunity(_ postId: Int) -> Future<Void, NetworkingError> {
        return dataSource.deleteCommunity(postId)
    }

    func postComment(
        _ postId: Int,
        _ content: String
    ) -> Future<Void, NetworkingError> {
        return dataSource.postComment(postId, content)
    }

    func fetchComment(_ postId: Int) -> AnyPublisher<[Comment], NetworkingError> {
        return dataSource.fetchComment(postId)
    }

}
