import Foundation

import Moya

enum RestAPI {

    // auth
    case login(id: String, password: String)
    case signup(id: String, password: String, name: String)
    case checkId(id: String)

    // community
    case postCommunity(title: String, content: String)
    case fetchCommunity
    case deleteCommunity(postId: Int)

    // comment
    case postComment(postId: Int, content: String)
    case fetchComment(postId: Int)
}

extension RestAPI: TargetType {

    var baseURL: URL {
        URL(string: "")!
    }

    var path: String {
        switch self {
        case .login:
            return "/login"
        case .signup:
            return "/signup"
        case .checkId:
            return "/auth"
        case .postCommunity, .fetchCommunity:
            return "/post"
        case .deleteCommunity(let postId):
            return "/post/\(postId)"
        case .postComment(let postId, _):
            return "/comment?post_id=\(postId)"
        default:
            return "/comment"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchCommunity, .fetchComment:
            return .get
        case .deleteCommunity:
            return .delete
        default:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .login(let id, let password):
            return .requestParameters(
                parameters: [
                    "id": id,
                    "password": password
                ],
                encoding: JSONEncoding.default
            )
        case .signup(let id, let password, let name):
            return .requestParameters(
                parameters: [
                    "id": id,
                    "password": password,
                    "name": name
                ],
                encoding: JSONEncoding.default
            )
        case .checkId(let id):
            return .requestParameters(
                parameters: [
                    "id": id
                ],
                encoding: JSONEncoding.default
            )
        case .postCommunity(let title, let content):
            return .requestParameters(
                parameters: [
                    "title": title,
                    "content": content
                ],
                encoding: JSONEncoding.default
            )
        case .postComment(_, let content):
            return .requestParameters(
                parameters: [
                    "content": content
                ], encoding: JSONEncoding.default
            )
        case .fetchComment(let postId):
            return .requestParameters(
                parameters: [
                    "post_id": postId
                ],
                encoding: URLEncoding.queryString
            )
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Authorization": "Bearer "]
    }
}
