import SwiftUI

struct CommunityView: View {
    @StateObject var viewModel = CommunityViewModel()
    @State var movePostScene: Bool = false
    @State var moveDetailScene: Bool = false
    @Binding var moveScene: Bool
    var body: some View {
        NavigationView {
            List(
                viewModel.communityList,
                id: \.id) { data in
                    NavigationLink {
                        DetailCommunityView(moveScene: $moveDetailScene)
                    } label: {
                        CommunityRow(
                            name: data.name,
                            title: data.title
                        ).onTapGesture {
                            moveDetailScene = true
                        }
                    }
                }.onAppear(perform: {
                    viewModel.apply(.getCommunity)
                })
        }.navigationTitle("커뮤니티")
            .font(.system(
                size: 15,
                weight: .bold
            )).navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink {
                    PostCommunityView(moveScene: $movePostScene)
                } label: {
                    Button {
                        movePostScene = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .frame(width: 18,
                                   height: 18)
                            .foregroundColor(.black)
                    }
                }
            }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView(moveScene: .constant(true))
    }
}
