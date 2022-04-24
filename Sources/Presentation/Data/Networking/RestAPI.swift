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
        URL(string: "http://13.124.231.212:5000")!
    }

    var path: String {
        switch self {
        case .login:
            return "/auths/login"
        case .signup:
            return "/auths/signups"
        case .checkId:
            return "/auths"
        case .postCommunity, .fetchCommunity:
            return "/posts"
        case .deleteCommunity:
            return "/posts"
        case .postComment(let postId, _):
            return "/comments?post_id=\(postId)"
        default:
            return "/commenst"
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
                    "userId": id
                ],
                encoding: URLEncoding.queryString
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
        case .deleteCommunity(let postId):
            return .requestParameters(
                parameters: [
                    "id": postId
                ],
                encoding: URLEncoding.queryString
            )
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .login, .signup, .checkId:
            return ["Content-type": "application/json"]
        default:
            let token = KeychainDataSource.shared.fetchAccessToken()
            return ["Authorization": "Barer \(token)"]
        }
    }
}
