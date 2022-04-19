import SwiftUI

struct LoginScene: View {
    @StateObject var viewModel = LoginViewModel()
    @State var moveSignup = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 40)

                HStack {
                    Spacer()
                        .frame(width: 30)
                    Text("물어\n볼램")
                        .font(.system(size: 50, weight: .bold))
                        .bold()
                    Spacer()
                }

                Spacer()
                    .frame(height: 150)

                HStack(spacing: 30) {
                    Spacer()
                    TextField("아이디를 입력해주세요.", text: $viewModel.id)
                        .background(Color.clear)
                        .foregroundColor(.black)
                        .padding(EdgeInsets(
                            top: 15,
                            leading: 10,
                            bottom: 15,
                            trailing: 10
                        ))
                        .border(.black, width: 0.5)
                    Spacer()
                }

                Spacer()
                    .frame(height: 20)

                HStack(spacing: 30) {
                    Spacer()
                    TextField("비밀번호를 입력해주세요.", text: $viewModel.password)
                        .background(Color.clear)
                        .foregroundColor(.black)
                        .padding(EdgeInsets(
                            top: 15,
                            leading: 10,
                            bottom: 15,
                            trailing: 10
                        ))
                        .border(.black, width: 0.5)
                    Spacer()
                }

                Spacer()

                Group {
                    Button {
                        print("login")
                    } label: {
                        HStack(spacing: 30) {
                            Spacer()
                            Text("로그인")
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
                            Spacer()
                        }
                    }

                    Spacer()
                        .frame(height: 50)

                    Button {
                        print("회원가입")
                    } label: {
                        HStack {
                            Text("아직 계정이 없다면?")
                                .foregroundColor(.black)
                            Spacer()
                                .frame(width: 15)
                            Text("회원가입 하러 가기")
                                .foregroundColor(.blue)
                        }.padding(EdgeInsets(
                            top: 10,
                            leading: 10,
                            bottom: 10,
                            trailing: 10
                        ))
                    }
                }
            }
            .navigationBarTitle(Text("로그인"), displayMode: .inline)
            .navigationColor(backgroundColor: .green, titleColor: .white)
        }
    }
}

struct LoginScene_Previews: PreviewProvider {
    static var previews: some View {
        LoginScene()
    }
}
