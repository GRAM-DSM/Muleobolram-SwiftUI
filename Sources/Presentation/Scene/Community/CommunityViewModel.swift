import Foundation

import Combine

class CommunityViewModel: ObservableObject {
    private let fetchCommunityUseCase: FetchCommunityUseCase

    enum Event {
        case getCommunity
    }

    struct Input {
        let getCommunity = PassthroughSubject<Void, Never>()
    }

    internal let input = Input()

    func apply(_ event: Event) {
        switch event {
        case .getCommunity:
            self.input.getCommunity.send(())
        }
    }

    init(fetchCommunityUseCase: FetchCommunityUseCase = FetchCommunityUseCase()) {
        self.fetchCommunityUseCase = fetchCommunityUseCase
    }
}
