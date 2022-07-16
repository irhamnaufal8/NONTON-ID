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
            Color.primaryBackground.ignoresSafeArea()
            
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
                    .frame(width: UIScreen.main.bounds.width - 32)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .onChange(of: viewModel.email) { value in
                        viewModel.disableButton()
                    }
                    
                    TextField(
                        LocalizableText.password.localized(viewModel.language),
                        text: $viewModel.password
                    )
                    .submitLabel(.done)
                    .autocapitalization(.none)
                    .foregroundColor(.primaryText)
                    .padding(12)
                    .frame(width: UIScreen.main.bounds.width - 32)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .onChange(of: viewModel.password) { value in
                        viewModel.disableButton()
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
                    .background(viewModel.isDisabled ? Color.gray : Color.primaryBlue)
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
                        viewModel.isSignUpView.toggle()
                    } label: {
                        Text(viewModel.isSignUpView ?
                             LocalizableText.login.localized(viewModel.language) :
                                LocalizableText.signUp.localized(viewModel.language))
                        .foregroundColor(.primaryBlue)
                        .font(.body.weight(.bold))
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
