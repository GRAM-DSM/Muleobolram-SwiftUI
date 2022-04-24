import SwiftUI

struct SignupView: View {
    @StateObject var viewModel = SignupViewModel()
    @Binding var moveScene: Bool

    var body: some View {
        NavigationView {
            VStack {

                Spacer()

                HStack(spacing: 30) {
                    Spacer()
                    ZStack {
                        TextField("아이디를 입력하세요", text: $viewModel.id)
                            .padding()
                            .border(.black, width: 0.5)
                        HStack {
                            Spacer()
                            Button {
                                viewModel.apply(.checkId)
                            } label: {
                                Text("확인")
                                    .font(.system(size: 10))
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 50, height: 30)
                                    .border(.black, width: 0.5)
                            }
                        }
                    }
                    Spacer()
                }

                Spacer()
                    .frame(height: 20)

                HStack(spacing: 30) {
                    Spacer()
                    TextField("이름을 입력하세요.", text: $viewModel.name)
                        .padding()
                        .border(.black, width: 0.5)
                    Spacer()
                }

                Spacer()
                    .frame(height: 20)

                HStack(spacing: 30) {
                    Spacer()
                    TextField("비밀번호를 입력해주세요", text: $viewModel.password)
                        .padding()
                        .border(.black, width: 0.5)
                    Spacer()
                }

                Spacer()

                HStack(spacing: 30) {
                    Spacer()
                    Button {
                        viewModel.apply(.signup)
                        self.moveScene = viewModel.isSuccess
                    } label: {
                        Text("회원가입")
                            .foregroundColor(Color.white)
                            .font(.system(size: 30, weight: .bold))
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                maxHeight: 70
                            )
                            .background(Color.green)
                            .cornerRadius(12)
                    }
                    Spacer()
                }

                Spacer()
                    .frame(height: 100)

            }.navigationBarTitle("회원가입", displayMode: .inline)
                .navigationColor(backgroundColor: .green, titleColor: .white)
        }
    }
}

struct SignupScene_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(moveScene: .constant(true))
    }
}
