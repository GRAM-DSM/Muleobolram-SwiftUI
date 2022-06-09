import Foundation

import Combine
import Moya

extension MoyaProvider {

    func requestPublisher<T: Decodable>(
        _ target: Target,
        _ model: T.Type
    ) -> AnyPublisher<T, NetworkingError> {
        return self.requestPublisher(target)
            .map(T.self)
            .mapError { NetworkingError($0) }
            .eraseToAnyPublisher()
    }

    func requestVoidPublisher(_ target: Target) -> Future<Void, NetworkingError> {
        return Future<Void, NetworkingError> { _ in
            self.requestPublisher(target)
            .map { _ in return }
            .mapError { NetworkingError($0) }
        }
    }
}
