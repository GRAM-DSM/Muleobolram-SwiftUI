import SwiftUI

struct PlaceholderTextEditor: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(uiColor: .placeholderText))
                    .padding(.vertical, 8)
            }
            TextEditor(text: $text)
        }.onAppear() {
            UITextView.appearance().backgroundColor = .clear
        }.onDisappear() {
            UITextView.appearance().backgroundColor = nil
        }
    }
}

struct PlaceholderTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderTextEditor(text: .constant(""), placeholder: "ㅇㄹㄴㅇㄹㄴㅇㄴㅇㄹㅇ")
    }
}
