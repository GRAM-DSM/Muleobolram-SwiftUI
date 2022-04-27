import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var moveSignup = false

    var body: some View {
        NavigationView {
        ZStack {
            Image.backgroundImage
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack {

                Spacer()
                    .frame(height: 290)

                AuthTxtField(title: "아이디를 입력해주세요", text: $viewModel.id)

                Spacer()
                    .frame(height: 10)

                        if !viewModel.isSuccess {
                                HStack(spacing: 35) {
                                    Spacer()
                                    VStack(alignment: .leading) {
                                    TextField("비밀번호를 입력해주세요.", text: $viewModel.password)
                                        .padding()
                                        .background(Color.txtField)
                                        .cornerRadius(5)
                                        .border(.red, width: 0.5)
                                        Text("아이디나 비밀번호가 일치하지 않습니다.")
                                            .font(.system(size: 11, weight: .semibold, design: .default))
                                            .foregroundColor(.red)
                                    }
                                    Spacer()
                                }
                        } else {
                            AuthTxtField(title: "비밀번호를 입력해주세요.", text: $viewModel.password)
                    Spacer()
                }

                Spacer()
                NavigationLink {
                    CommunityView(moveScene: $viewModel.isSuccess)
                } label : {
                    Button {
                        self.viewModel.apply(.login)
                    } label: {
                        HStack(spacing: 30) {
                            Spacer()
                            Text("로그인")
                                .font(.system(size: 15, weight: .semibold, design: .default))
                                .foregroundColor(Color.authButton)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color.txtField)
                            Spacer()
                        }
                    }
                }

                Spacer()
                    .frame(height: 67)

                Button {
                    moveSignup.toggle()
                } label: {
                    Text("회원가입하기 >")
                        .font(.system(size: 11, weight: .medium, design: .default))
                        .foregroundColor(Color.moveSignupTxt)
                        .fullScreenCover(isPresented: $moveSignup) {
                            SignupView(moveScene: $moveSignup)
                        }
                }

                Spacer()
            }
        }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
