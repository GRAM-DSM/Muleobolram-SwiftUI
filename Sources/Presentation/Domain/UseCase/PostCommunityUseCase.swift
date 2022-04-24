import Foundation

import Combine

class PostCommunityUseCase {
    private let repository: Repository

    init(repository: Repository = DefaultRepository()) {
        self.repository = repository
    }

    func execute(
        title: String,
        content: String
    ) -> Future<Void, NetworkingError> {
        return repository.postCommunity(title, content)
    }
}
