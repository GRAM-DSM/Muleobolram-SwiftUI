import Foundation

import Combine

class PostCommentUseCase {
    private let repository: Repository

    init(repository: Repository = DefaultRepository()) {
        self.repository = repository
    }

    func execute(
        postId: Int,
        content: String
    ) -> Future<Void, NetworkingError> {
        return repository.postComment(postId, content)
    }
}
