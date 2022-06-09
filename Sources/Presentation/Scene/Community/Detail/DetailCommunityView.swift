import SwiftUI

struct DetailCommunityView: View {
    @Binding var moveScene: Bool
    var body: some View {
        VStack {
            Text("헬로우 뿩킹 비치")
        }
    }
}

struct DetailCommunityView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCommunityView(moveScene: .constant(false))
    }
}
