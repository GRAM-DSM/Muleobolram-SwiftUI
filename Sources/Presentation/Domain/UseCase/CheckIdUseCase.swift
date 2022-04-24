import Foundation

import Combine

class CheckIdUseCase {
    private let repository: Repository

    init(repository: Repository = DefaultRepository()) {
        self.repository = repository
    }

    func execute(id: String) -> Future<Void, NetworkingError> {
        return repository.checkId(id)
    }
}
