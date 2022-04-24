import Foundation

import Combine

class SignupViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var isSuccess: Bool = true
    @Published var checkId: Bool = true

    private let signupUseCase: SignupUseCase
    private let checkIdUseCase: CheckIdUseCase

    private var bag = Set<AnyCancellable>()

    enum Event {
        case signup
        case checkId
    }

    struct Input {
        let signupButtonDidTap = PassthroughSubject<Void, Never>()
        let checkIdButtonDidTap = PassthroughSubject<Void, Never>()
    }

    internal let input: Input = Input()

    func apply(_ event: Event) {
        switch event {
        case .signup:
            self.input.signupButtonDidTap.send(())
        case .checkId:
            self.input.checkIdButtonDidTap.send(())
        }
    }

    init(
        signupUseCase: SignupUseCase = SignupUseCase(),
        checkIdUseCase: CheckIdUseCase = CheckIdUseCase()
    ) {
        self.signupUseCase = signupUseCase
        self.checkIdUseCase = checkIdUseCase

        input.signupButtonDidTap
            .flatMap {
                self.signupUseCase.exceute(
                    id: self.id,
                    password: self.password,
                    name: self.name
                ).catch { error -> Empty<Void, Never> in
                    print(self.getErrorMessage(error: error))
                    self.isSuccess = true
                    return .init()
                }
            }.sink { [weak self] _ in
                self?.isSuccess = false
            }.store(in: &bag)

        input.checkIdButtonDidTap
            .flatMap {
                self.checkIdUseCase.execute(id: self.id)
                    .catch { error -> Empty<Void, Never> in
                        print(self.getErrorMessage(error: error))
                        self.checkId = false
                        return .init()
                    }
            }.sink { [weak self] in
                self?.checkId = true
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
