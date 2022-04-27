import SwiftUI

struct SignupView: View {
    @StateObject var viewModel = SignupViewModel()
    @Binding var moveScene: Bool

    var body: some View {
        ZStack {
            Image.backgroundImage
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                    .frame(height: 89)
                HStack {
                    Spacer()
                        .frame(width: 48)
                    Button {
                        self.moveScene.toggle()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                            .frame(width: 18, height: 18)
                            .padding()
                    }
                    Spacer()
                }

                Spacer()
                Group {
                    HStack(spacing: 35) {
                        Spacer()
                        ZStack(alignment: .trailing) {
                            VStack(alignment: .leading) {
                                Text("아이디")
                                    .font(.system(size: 9, weight: .medium, design: .default))
                                    .foregroundColor(.txtTitle)
                                TextField("아이디를 입력해주세요.", text: $viewModel.id)
                            }.padding()
                                .frame(height: 70)
                                .background(Color.txtField)
                                .cornerRadius(5)
                            Button {
                                viewModel.apply(.checkId)
                            } label: {
                                Text("중복확인")
                                    .font(.system(size: 12, weight: .medium, design: .default))
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(height: 40)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                Spacer()
                                    .frame(width: 5)
                            }
                        }
                        Spacer()
                    }

                    HStack(spacing: 35) {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("비밀번호")
                                .font(.system(size: 9, weight: .medium, design: .default))
                                .foregroundColor(.txtTitle)
                            TextField("비밀번호를 입력해주세요.", text: $viewModel.id)
                        }.padding()
                            .frame(height: 70)
                            .background(Color.txtField)
                            .cornerRadius(5)
                        Spacer()
                    }

                    HStack(spacing: 35) {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("이름")
                                .font(.system(size: 9, weight: .medium, design: .default))
                                .foregroundColor(.txtTitle)
                            TextField("이름을 입력해주세요.", text: $viewModel.id)
                        }.padding()
                            .frame(height: 70)
                            .background(Color.txtField)
                            .cornerRadius(5)
                        Spacer()
                    }
                }

                Spacer()

                Button {
                    viewModel.apply(.signup)
                } label: {
                    HStack(spacing: 30) {
                        Spacer()
                        Text("회원가입")
                            .font(.system(size: 15, weight: .semibold, design: .default))
                            .foregroundColor(Color.authButton)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.txtField)
                            .cornerRadius(5)
                        Spacer()
                    }
                }

                Spacer()
            }
        }
    }
}

struct SignupScene_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(moveScene: .constant(true))
    }
}
