import Foundation

import Combine

class LoginUseCase {
    private let repository: Repository

    init(repository: Repository = DefaultRepository()) {
        self.repository = repository
    }

    func execute(
        id: String,
        password: String
    ) -> Future<Void, NetworkingError> {
        return repository.login(id, password)
    }
}
