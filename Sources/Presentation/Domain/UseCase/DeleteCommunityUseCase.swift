import Foundation

import Combine

class DeleteCommunityUseCase {
    private let repository: Repository

    init(repository: Repository = DefaultRepository()) {
        self.repository = repository
    }

    func execute(postId: Int) -> Future<Void, NetworkingError> {
        return repository.deletCommunity(postId)
    }
}
