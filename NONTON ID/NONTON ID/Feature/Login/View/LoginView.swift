//
//  LoginView.swift
//  NONTON ID
//
//  Created by Garry on 16/07/22.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
//            Color.primaryBackground.ignoresSafeArea()
            LinearGradient.background.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Image.logoNontonID
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width - 200)
                        .padding()
                    
                    Image.loginIllustration
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width - 170)
                        .padding()
                    
                    if viewModel.isError == true {
                        Text(viewModel.errorMessage.localized(viewModel.language))
                            .font(.caption)
                            .foregroundColor(.red)
                            .frame(width: UIScreen.main.bounds.width - 32)
                    }
                    
                    VStack {
                        TextField(
                            LocalizableText.email.localized(viewModel.language),
                            text: $viewModel.email
                        )
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(.primaryText)
                        .padding(12)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 46)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .onChange(of: viewModel.email) { value in
                            viewModel.activateButton()
                        }
                        
                        HStack {
                            if viewModel.isHidden == true {
                                SecureField(
                                    LocalizableText.password.localized(viewModel.language),
                                    text: $viewModel.password
                                )

                            } else {
                                TextField(
                                    LocalizableText.password.localized(viewModel.language),
                                    text: $viewModel.password
                                )
                            }

                            Button {
                                viewModel.hidePasswordToggle()
                            } label: {
                                Image(systemName: viewModel.isHidden ? "eye.slash" : "eye")
                                    .foregroundColor(viewModel.isHidden ? Color.gray : Color.primaryText)
                            }
                        }
                        .autocapitalization(.none)
                        .foregroundColor(.primaryText)
                        .padding(12)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 46)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .onChange(of: viewModel.password) { value in
                            viewModel.activateButton()
                        }
                        
                        if viewModel.isSignUpView {
                            TextField(
                                LocalizableText.username.localized(viewModel.language),
                                text: $viewModel.username
                            )
                            .autocapitalization(.none)
                            .foregroundColor(.primaryText)
                            .padding(12)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 46)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                            .onChange(of: viewModel.username) { value in
                                viewModel.activateButton()
                            }
                        }
                    }
                    .onSubmit {
                        hideKeyboard()
                    }
                    
                    Button {
                        hideKeyboard()
                        viewModel.handleAction()
                    } label: {
                        Text(viewModel.isSignUpView ?
                             LocalizableText.signUp.localized(viewModel.language) :
                                LocalizableText.login.localized(viewModel.language))
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(12)
                        .frame(width: UIScreen.main.bounds.width - 32)
                        .background(viewModel.isDisabled ? LinearGradient.gray : LinearGradient.gradient)
                        .cornerRadius(6)
                        .padding()
                    }
                    .disabled(viewModel.isDisabled)

                    Divider()
                        .padding()
                    
                    HStack {
                        Text(viewModel.isSignUpView ?
                             LocalizableText.loginQuestion.localized(viewModel.language) :
                                LocalizableText.signUpQuestion.localized(viewModel.language))
                        .foregroundColor(.primaryText)
                        .font(.body)
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                viewModel.loginSignUpToggle()
                            }
                        } label: {
                            Text(viewModel.isSignUpView ?
                                 LocalizableText.login.localized(viewModel.language) :
                                    LocalizableText.signUp.localized(viewModel.language))
                            .foregroundColor(.purple)
                            .font(.body.weight(.bold))
                        }

                    }
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            viewModel.onStartFetch()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
        
        LoginView()
            .preferredColorScheme(.light)
    }
}
