import Foundation

import Swinject

extension Container {

    func registerServiceDependencies() {
        registerUseCase()
        registerRepository()
    }

    private func registerRepository() {
        self.register(Repository.self) { _ in DefaultRepository() }
    }

    private func registerUseCase() {
        self.register(LoginUseCase.self) { resolver in
            return LoginUseCase(repository: resolver.resolve(Repository.self)!)
        }
        self.register(SignupUseCase.self) { resolver in
            return SignupUseCase(repository: resolver.resolve(Repository.self)!)
        }
        self.register(CheckIdUseCase.self) { resolver in
            return CheckIdUseCase(repository: resolver.resolve(Repository.self)!)
        }
        self.register(PostCommunityUseCase.self) { resolver in
            return PostCommunityUseCase(repository: resolver.resolve(Repository.self)!)
        }
        self.register(FetchCommunityUseCase.self) { resolver in
            return FetchCommunityUseCase(repository: resolver.resolve(Repository.self)!)
        }
        self.register(DeleteCommunityUseCase.self) { resolver in
            return DeleteCommunityUseCase(repository: resolver.resolve(Repository.self)!)
        }
        self.register(PostCommentUseCase.self) { resolver in
            return PostCommentUseCase(repository: resolver.resolve(Repository.self)!)
        }
        self.register(FetchCommentUseCase.self) { resolver in
            return FetchCommentUseCase(repository: resolver.resolve(Repository.self)!)
        }
    }
}
