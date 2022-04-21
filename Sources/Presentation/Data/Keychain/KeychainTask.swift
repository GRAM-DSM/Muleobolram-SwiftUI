import Foundation

import Security

final class KeychainTask {

    static let shared = KeychainTask()

    private let service = Bundle.main.bundleIdentifier!

    private init() { }

    func register(accountType: KeychainAccountType, value: String) {
        let keychainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: accountType.rawValue,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]
        SecItemDelete(keychainQuery)
        SecItemAdd(keychainQuery, nil)
    }

    func fetch(accountType: KeychainAccountType) -> String? {
        let ketchainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: accountType.rawValue,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(ketchainQuery, &dataTypeRef)
        if status == errSecSuccess {
            let retrievedData = (dataTypeRef as? Data)!
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value!
        } else { return nil }
    }

    func delete(accountType: KeychainAccountType) {
        let keychainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: accountType.rawValue
        ]
        SecItemDelete(keychainQuery)
    }
}

enum KeychainAccountType: String {
    case accessToken = "ACCESS-TOKEN"
    case refreshToken = "REFRESH-TOKEN"
}
