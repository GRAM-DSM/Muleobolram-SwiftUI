import Foundation

import Moya

enum NetworkingError: Int, Error {
    case success = 200
    case createOk = 201
    case badReq = 400
    case tokenError = 401
    case forbidden = 403
    case notFount = 404
    case conflict = 409
    case fail = 0

    init(_ error: MoyaError) {
        self = NetworkingError(rawValue: error.response!.statusCode) ?? .fail
    }

    init(_ error: Error) {
        if let moyaError = error as? MoyaError {
            self = NetworkingError(moyaError)
        } else {
            self = .fail
        }
    }

    var message: String {
        switch self {
        case .badReq:
            return "잘못된 Request"
        case .tokenError:
            return "토큰 에러"
        case .notFount:
            return "게시물을 찾을 수가 없음"
        case .forbidden:
            return "권한 없음."
        default:
            return ""
        }
    }
}
