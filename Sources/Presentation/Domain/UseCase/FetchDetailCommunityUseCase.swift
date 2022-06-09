import Foundation

import Combine

class FetchDetailCommunityUseCase {
    private let repository: Repository

    init(repository: Repository = DefaultRepository()) {
        self.repository = repository
    }

    func execute(_ postId: Int) -> Future<CommunityDetail, NetworkingError> {
        return repository.fetchDetailCommunity(postId)
    }
}
