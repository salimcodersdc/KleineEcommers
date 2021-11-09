//
//  RegisterScreen.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

protocol RegisterViewModelServiceProtocol {
    func register()
}

class RegisterViewModelService: RegisterViewModelServiceProtocol {
    func register() {
        
    }
    
}

class RegisterViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    
    var service: RegisterViewModelServiceProtocol
    
    init(service: RegisterViewModelServiceProtocol) {
        self.service = service
    }
}
struct RegisterScreen: View {
    
    @Binding var page: UnAuthController.Page
    @StateObject var viewModel: RegisterViewModel
    
    init(page: Binding<UnAuthController.Page>,
         service: RegisterViewModelServiceProtocol = RegisterViewModelService()) {
        self._page = page
        self._viewModel = StateObject(wrappedValue: RegisterViewModel(service: service))
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

extension RegisterScreen {
    private var gradientLayer: some View {
        
        LinearGradient(
            gradient: Gradient(colors: [
                Color.fromHexString("000DAE").opacity(0.8),
                Color.fromHexString("849DFE").opacity(0.8),
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
            
            Text("Let's Register.")
                .font(Font.fontBook.bold(34))
                .foregroundColor(Color.white)
            
            Button(action: {
                page = .login
            }, label: {
                Text("Don't you have an account? Login")
                    .font(Font.fontBook.regular(12))
                    .foregroundColor(Color.white)
                    .padding(.top)
            })
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var textFields: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("your name", text: $viewModel.firstName)
                .textFieldStyle(KleineTextFieldStyle())
            
            TextField("Password", text: $viewModel.password)
                .textFieldStyle(KleineTextFieldStyle())
            
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(KleineTextFieldStyle())
            
            TextField("Phone", text: $viewModel.phone)
                .textFieldStyle(KleineTextFieldStyle())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 32)
    }
    
    private var loginButton: some View {
        Button(action: {}, label: {
            Text("Register")
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

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen(page: .constant(.register))
    }
}
