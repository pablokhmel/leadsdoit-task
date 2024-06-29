import SwiftUI

extension View {
    func customOnChange<Value: Equatable>(of value: Value, perform action: @escaping () -> Void) -> some View {
        if #available(iOS 17.0, *) {
            return self.onChange(of: value) {
                action()
            }
        } else {
            return self.onChange(of: value) { _ in
                action()
            }
        }
    }
}
