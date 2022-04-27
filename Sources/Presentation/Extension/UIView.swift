import Foundation
import UIKit

extension UIView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIApplication.shared.windows
            .first { $0.isKeyWindow }?
            .endEditing(true)
    }
}
