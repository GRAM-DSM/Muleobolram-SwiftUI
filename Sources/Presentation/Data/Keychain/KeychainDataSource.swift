import Foundation

final class KeychainDataSource {

    static let shared = KeychainDataSource()

    private let ketchainTask = KeychainTask.shared

    private init() { }

    func registerAccessToken(_ accessToken: String) {
        ketchainTask.register(accountType: .accessToken, value: accessToken)
    }

    func fetchAccessToken() -> String {
        ketchainTask.fetch(accountType: .accessToken) ?? ""
    }

    func registerRefreshToken(_ refreshToken: String) {
        ketchainTask.register(accountType: .refreshToken, value: refreshToken)
    }

    func fetchRefreshToken() -> String {
        ketchainTask.fetch(accountType: .refreshToken) ?? ""
    }
}
