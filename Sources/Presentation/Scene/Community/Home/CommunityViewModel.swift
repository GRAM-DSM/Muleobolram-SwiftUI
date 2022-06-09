import Foundation

import Combine

class CommunityViewModel: ObservableObject {
    private let fetchCommunityUseCase: FetchCommunityUseCase

    @Published var communityList = [Community]()

    enum Event {
        case getCommunity
    }

    struct Input {
        let getCommunity = PassthroughSubject<Void, Never>()
    }

    internal let input = Input()
    private var bag = Set<AnyCancellable>()

    func apply(_ event: Event) {
        switch event {
        case .getCommunity:
            self.input.getCommunity.send(())
        }
    }

    init(fetchCommunityUseCase: FetchCommunityUseCase = FetchCommunityUseCase()) {
        self.fetchCommunityUseCase = fetchCommunityUseCase

        input.getCommunity
            .flatMap {
                self.fetchCommunityUseCase.execute()
                    .catch { error -> Empty<[Community], Never> in
                        print(error.message)
                        return .init()
                    }
            }.sink { [weak self] in
                self?.communityList = $0
            }.store(in: &bag)
    }
}
