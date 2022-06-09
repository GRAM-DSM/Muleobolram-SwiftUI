import SwiftUI

struct DetailCommunityView: View {
    @StateObject var viewModel = DetailCommunityViewModel()
    @Binding var moveScene: Bool

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack(spacing: 40) {
                    Spacer()
                    Text(viewModel.community.title)
                    Spacer()
                }
                HStack(spacing: 40) {
                    Spacer()
                    TextEditor(text: $viewModel.community.content)
                        .disabled(true)
                    Spacer()
                }
                HStack(spacing: 40) {
                    Spacer()
                    ZStack {
                        HStack(spacing: 15) {
                            Spacer()
                            TextField("댓글을 입력하세요.", text: $viewModel.comment)
                                .font(.system(size: 13, weight: .medium))
                            Spacer()
                        }.overlay {
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(.gray, lineWidth: 0.5)
                                .frame(minWidth: 0,
                                       maxWidth: .infinity, minHeight: 36, maxHeight: 36)
                        }
                        if !viewModel.comment.isEmpty {
                            HStack {
                                Spacer()
                                Button {
                                    print("!!")
                                } label: {
                                    Text("전송")
                                        .foregroundColor(.green)
                                }
                                Spacer()
                                    .frame(width: 20)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }.navigationTitle("댓글달기")
    }
}

struct DetailCommunityView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCommunityView(moveScene: .constant(false))
    }
}
