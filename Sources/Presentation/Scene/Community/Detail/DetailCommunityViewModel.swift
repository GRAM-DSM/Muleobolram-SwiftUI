import Foundation

import Combine

class DetailCommunityViewModel: ObservableObject {
    private let fetchDetailCommunityUseCase: FetchDetailCommunityUseCase

    @Published var community: CommunityDetail = .init(id: 0, title: "", content: "", userId: 0)
    @Published var comment: String = ""

    enum Event {
        case viewDidAppear(_ postId: Int)
    }

    struct Input {
        let fetchDetailCommunity = PassthroughSubject<Int, Never>()
    }

    internal let input = Input()
    private var bag = Set<AnyCancellable>()

    func apply(_ event: Event) {
        switch event {
        case .viewDidAppear(let postId):
            input.fetchDetailCommunity.send(postId)
        }
    }

    init(fetchDetailCommunityUseCase: FetchDetailCommunityUseCase = FetchDetailCommunityUseCase()) {
        self.fetchDetailCommunityUseCase = fetchDetailCommunityUseCase

        input.fetchDetailCommunity
            .flatMap {
                self.fetchDetailCommunityUseCase.execute($0)
                    .catch { error -> Empty<CommunityDetail, Never> in
                        print(error.message)
                        return .init()
                    }
            }.sink { [weak self] in
                self?.community = $0
            }.store(in: &bag)
    }
}
