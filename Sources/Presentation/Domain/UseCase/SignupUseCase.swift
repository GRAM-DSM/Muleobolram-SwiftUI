import Foundation

import Combine

class SignupUseCase {
    private let repository: Repository

    init(repository: Repository = DefaultRepository()) {
        self.repository = repository
    }

    func exceute(
        id: String,
        password: String,
        name: String
    ) -> Future<Void, NetworkingError> {
        return repository.signup(id, password, name)
    }
}
