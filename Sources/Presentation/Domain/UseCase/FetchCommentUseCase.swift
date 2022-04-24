import Foundation

import Combine

class FetchCommentUseCase {
    private let repository: Repository

    init(repository: Repository = DefaultRepository()) {
        self.repository = repository
    }

    func execute(postId: Int) -> AnyPublisher<[Comment], NetworkingError> {
        return repository.fetchComment(postId)
    }
}
