import Foundation

import Combine

class FetchCommunityUseCase {
    private let repository: Repository

    init(repository: Repository = DefaultRepository()) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[Community], NetworkingError> {
        return repository.fetchCommunity()
    }
}
