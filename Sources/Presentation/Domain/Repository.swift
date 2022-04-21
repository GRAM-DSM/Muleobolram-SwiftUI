import Foundation

import Combine

protocol Repository {
    // auth
    func login(_ id: String, _ password: String) -> AnyPublisher<Void, NetworkingError>
    func signup(_ id: String, _ password: String, _ name: String) -> Future<Void, NetworkingError>
    func checkId(_ id: String) -> Future<Void, NetworkingError>

    // community
    func postCommunity(_ title: String, _ content: String) -> Future<Void, NetworkingError>
    func fetchCommunity() -> AnyPublisher<[Community], NetworkingError>
    func deletCommunity(_ postId: Int) -> Future<Void, NetworkingError>

    // comment
    func postComment(_ postId: Int, _ content: String) -> Future<Void, NetworkingError>
    func fetchComment(_ postId: Int) -> AnyPublisher<[Comment], NetworkingError>
}
