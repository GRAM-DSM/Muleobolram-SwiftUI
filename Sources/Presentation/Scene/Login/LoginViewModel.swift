import Foundation

import Combine

class LoginViewModel: ObservableObject {

    private let loginUseCase: LoginUseCase

    @Published var id: String = ""
    @Published var password: String = ""
    @Published var isSuccess: Bool = true

    private var bag = Set<AnyCancellable>()

    enum Event {
        case login
    }

    struct Input {
        let loginBtnDidTap = PassthroughSubject<Void, Never>()
    }

    internal let input = Input()

    func apply(_ event: Event) {
        switch event {
        case .login:
            self.input.loginBtnDidTap.send(())
        }
    }

    init(loginUseCase: LoginUseCase = LoginUseCase()) {
        self.loginUseCase = loginUseCase

        input.loginBtnDidTap
            .flatMap {
                self.loginUseCase.execute(id: self.id, password: self.password)
                    .catch { error -> Empty<Void, Never> in
                        print(self.getErrorMessage(error: error))
                        self.isSuccess = false
                        return .init()
                    }
            }.sink { [weak self] _ in
                self?.isSuccess = true
            }.store(in: &bag)
    }

    private func getErrorMessage(error: NetworkingError) -> String {
        switch error {
        case .badReq:
            return "body 요청이 잘못됨."
        case .conflict:
            return "아이디가 겹침"
        default:
            return error.message
        }
    }
}
