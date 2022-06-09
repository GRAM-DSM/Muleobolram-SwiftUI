import Foundation

import Combine

class PostCommunityViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var isSuccess: Bool = true

    private let postCommunityUseCase: PostCommunityUseCase

    private var bag = Set<AnyCancellable>()

    enum Event {
       case postCommunity
    }

    struct Input {
        let postCommunity = PassthroughSubject<Void, Never>()
    }

    func apply(_ event: Event) {
        switch event {
        case .postCommunity:
            input.postCommunity.send(())
        }
    }

    internal let input = Input()

    init(postCommunityUseCase: PostCommunityUseCase = PostCommunityUseCase()) {
        self.postCommunityUseCase = postCommunityUseCase

        input.postCommunity
            .flatMap { self.postCommunityUseCase.execute(
                title: self.title,
                content: self.content
            ).catch { error -> Empty<Void, Never> in
                print(self.getErrorMessage(error: error))
                self.isSuccess = true
                return .init()
            }}.sink { [weak self] in
                self?.isSuccess = false
            }.store(in: &bag)
    }

    private func getErrorMessage(error: NetworkingError) -> String {
        switch error {
        case .tokenError:
            return "token error!"
        case .badReq:
            return "body 요청이 잘못됨!"
        default:
            return NetworkingError(error).message
        }
    }
}
