//
//  LoginScreen.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

struct LoginScreen: View {
    
    @Binding var page: UnAuthController.Page
    @StateObject var viewModel: LoginViewModel
    
    init(page: Binding<UnAuthController.Page>, service: LoginViewModelServiceProtocol = LoginViewModelService()) {
        self._viewModel = StateObject(wrappedValue: LoginViewModel(service: service))
        self._page = page
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.theme.mainBackground
            
            PartialMobileBackground(showLogo: false,
                                    darkColor: Color.fromHexString("#B0B6FF"),
                                    lightColor: Color.fromHexString("#F5F8FA"))
            
            gradientLayer
            
            content
        }
    }
}

extension LoginScreen {
    private var gradientLayer: some View {
        
        LinearGradient(
            gradient: Gradient(colors: [
                Color.fromHexString("000DAE").opacity(0.8),
                Color.fromHexString("849DFE").opacity(0.8),
                Color.white,
                Color.white
            ]),
            startPoint: .top,
            endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            
            Spacer()
                .frame(height: 80)
            
            header
            
            textFields
            
            loginButton
            
            socialLoginButtons
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var header: some View {
        VStack(alignment: .leading) {
            LogoView()
            
            Text("Let's Login.")
                .font(Font.fontBook.bold(34))
                .foregroundColor(Color.white)
            
            Button(action: {
                page = .register
            }, label: {
                Text("Don't you have an account? Register")
                    .font(Font.fontBook.regular(12))
                    .foregroundColor(Color.white)
                    .padding(.top)
            })
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var textFields: some View {
        VStack(alignment: .leading, spacing: 16) {
            
//            if let emailMessage = viewModel.emailValidationMessage {
//                Text(emailMessage)
//            }
            
            TextField("your user email", text: $viewModel.userName)
                .textFieldStyle(KleineTextFieldStyle())
                .border(viewModel.isUserNameValid ? Color.white : Color.red)
            
//            if let passwordMessage = viewModel.passwordValidationMessage {
//                Text(passwordMessage)
//            }
            
            TextField("Password", text: $viewModel.password)
                .textFieldStyle(KleineTextFieldStyle())
                .border(viewModel.isPasswordValid ? Color.white : Color.red)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 32)
    }
    
    private var loginButton: some View {
        Button(action: {
            viewModel.login()
        }, label: {
            Text("Login")
                .font(Font.fontBook.semiBold())
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(
                    Rectangle()
                        .fill(Color.theme.primary)
                        .cornerRadius(8)
                )
        })
        .padding(.top, 32)
        .disabled(!viewModel.isValid)
        .opacity(viewModel.isValid ? 1 : 0.6)
    }
    
    private var socialLoginButtons: some View {
        HStack {
            Button(action: {}, label: {
                KleineSocialLogin(label: "FaceBook") {
                    Image("facebook")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 25, height: 25)
                        .padding(.leading, 8)
                        .padding(.top, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.theme.secondary)
                    )
                }
            })
            
            Spacer()
            
            Button(action: {}, label: {
                KleineSocialLogin(label: "Google") {
                    Image("google")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 25, height: 25)
                }
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(page: .constant(.login))
    }
}

struct KleineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding()
            .background(
                Rectangle()
                    .fill(Color.white)
            )
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

struct KleineSocialLogin<ImageView: View>: View {
    
    var label: String
    
    var imageView: ImageView
    
    init(label: String, @ViewBuilder imageView: () -> ImageView) {
        self.label = label
        self.imageView = imageView()
    }
    
    
    var body: some View {
        HStack {
            imageView
            
            Text(label)
                .font(Font.fontBook.semiBold(12))
                .foregroundColor(Color.theme.secondary)
        }
        .padding()
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.theme.secondary)
        )
    }
}
