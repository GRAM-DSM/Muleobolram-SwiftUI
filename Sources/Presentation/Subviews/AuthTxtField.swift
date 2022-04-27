import SwiftUI

struct AuthTxtField: View {
    @State internal var title: String
    internal var text: Binding<String>
    var body: some View {
        HStack(spacing: 35) {
            Spacer()
            TextField(title, text: text)
                .padding()
                .background(Color.txtField)
                .cornerRadius(5)
            Spacer()
        }
    }
}

struct AuthTxtField_Previews: PreviewProvider {
    static var previews: some View {
        AuthTxtField(title: "안녕하세요", text: .constant("gg"))
    }
}
