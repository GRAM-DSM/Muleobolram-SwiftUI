import Foundation

import Combine

class DetailCommunityViewModel: ObservableObject {
    private let fetchDetailCommunityUseCase: FetchDetailCommunityUseCase
    private let fetchCommentUseCase: FetchCommentUseCase
    private let postCommentUseCase: PostCommentUseCase
    private let deleteCommunityUseCase: DeleteCommunityUseCase

    @Published var community: CommunityDetail = .init(id: 0, title: "", content: "", userId: 0)
    @Published var commentList = [Comment]()
    @Published var comment: String = ""
    @Published var postId: Int = .init()
    @Published var deleteSuccess: Bool = true

    enum Event {
        case viewDidAppear
        case postComment
        case deletePost
    }

    struct Input {
        let fetchDetailCommunity = PassthroughSubject<Void, Never>()
        let postComment = PassthroughSubject<Void, Never>()
        let deletePost = PassthroughSubject<Void, Never>()
    }

    internal let input = Input()
    private var bag = Set<AnyCancellable>()

    func apply(_ event: Event) {
        switch event {
        case .viewDidAppear:
            input.fetchDetailCommunity.send(())
        case .postComment:
            input.postComment.send(())
        case .deletePost:
            input.deletePost.send(())
        }
    }

    init(
        fetchDetailCommunityUseCase: FetchDetailCommunityUseCase = FetchDetailCommunityUseCase(),
        fetchCommentUseCase: FetchCommentUseCase = FetchCommentUseCase(),
        postCommentUseCase: PostCommentUseCase = PostCommentUseCase(),
        deleteCommunityUseCase: DeleteCommunityUseCase = DeleteCommunityUseCase()
    ) {
        self.fetchDetailCommunityUseCase = fetchDetailCommunityUseCase
        self.fetchCommentUseCase = fetchCommentUseCase
        self.postCommentUseCase = postCommentUseCase
        self.deleteCommunityUseCase = deleteCommunityUseCase

        input.fetchDetailCommunity
            .flatMap {
                self.fetchDetailCommunityUseCase.execute(self.postId)
                    .catch { error -> Empty<CommunityDetail, Never> in
                        print(error.message)
                        return .init()
                    }
            }.sink { [weak self] in
                self?.community = $0
            }.store(in: &bag)

        input.fetchDetailCommunity
            .flatMap {
                self.fetchCommentUseCase.execute(postId: self.postId)
                    .catch { error -> Empty<[Comment], Never> in
                        print(error.message)
                        return .init()
                    }
            }.sink {
                self.commentList = $0
            }.store(in: &bag)

        input.postComment
            .flatMap {
                self.postCommentUseCase.execute(postId: self.postId, content: self.comment)
                    .catch { error -> Empty<Void, Never> in
                        print(error.message)
                        return .init()
                    }
            }.sink { [weak self] in
                self?.input.fetchDetailCommunity.send(())
            }.store(in: &bag)

        input.deletePost
            .flatMap {
                self.deleteCommunityUseCase.execute(postId: self.postId)
                    .catch { error -> Empty<Void, Never> in
                        print(error.message)
                        self.deleteSuccess = true
                        return .init()
                    }
            }.sink {
                self.deleteSuccess = false
            }.store(in: &bag)
    }
}
