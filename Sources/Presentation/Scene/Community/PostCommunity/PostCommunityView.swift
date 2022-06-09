import SwiftUI

struct PostCommunityView: View {
    @Binding var moveScene: Bool
    @State var showingAlert: Bool = false
    @StateObject var viewModel = PostCommunityViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 70)
                HStack(spacing: 30) {
                    Spacer()
                    HStack {
                        Spacer()
                            .frame(width: 15)
                        TextField("글 제목을 입력해주세요. (최대 30 글자)", text: $viewModel.title)
                            .font(.system(size: 13, weight: .medium))
                        Spacer()
                    }
                    .frame(height: 32)
                    .border(.gray)
                    Spacer()
                }
                Spacer()
                    .frame(height: 15)
                HStack(spacing: 30) {
                    Spacer()
                    HStack {
                        Spacer()
                            .frame(width: 15)
                        PlaceholderTextEditor(text: $viewModel.content, placeholder: "내용을 입력해주세요. (최대 255글자)")
                            .font(.system(size: 13, weight: .medium))
                    }
                    .background(.white)
                    .frame(height: 200)
                    .border(.gray)
                    Spacer()
                }
                Spacer()
            }
        }.navigationTitle("글쓰기")
            .font(.system(size: 15, weight: .bold))
            .toolbar {
                Button {
                    showingAlert = true
                } label: {
                    Text("완료")
                        .font(.system(size: 15,
                                      weight: .medium))
                        .padding()
                }.alert("정말 이 글을 커뮤니티에\n게시하겠습니까?",
                        isPresented: $showingAlert,
                        actions: {
                    Button("확인") {
                        viewModel.apply(.postCommunity)
                        self.moveScene = viewModel.isSuccess
                    }
                    Button("취소") {
                        showingAlert = false
                    }
                }).disabled(viewModel.title.isEmpty && viewModel.content.isEmpty)
            }
    }
}

struct PostCommunityView_Previews: PreviewProvider {
    static var previews: some View {
        PostCommunityView(moveScene: .constant(true))
    }
}
