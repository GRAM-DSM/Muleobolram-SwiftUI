import SwiftUI

struct CommunityView: View {
    @StateObject var viewModel = CommunityViewModel()
    @Binding var moveScene: Bool
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                self.viewModel.apply(.getCommunity)
            }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView(moveScene: .constant(true))
    }
}
