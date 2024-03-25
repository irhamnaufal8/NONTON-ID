//
//  ProfileView.swift
//  NONTON ID
//
//  Created by Garry on 23/07/22.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel = ProfileViewModel()
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack {
            Text((viewModel.user.value?.email).orEmpty())
            TextField("User..", text: viewModel.binding(\.user, for: \.email, defaultValue: "yuhuu"))
            
            Text((viewModel.userWithMeta.value?.data?.email).orEmpty())
            TextField("Another user..", text: viewModel.binding(
                \.userWithMeta,
                for: { $0.data?.email },
                setField: { $0.data?.email = $1 },
                defaultValue: "ahayy"
            ))
            
        }
//        ZStack {
//            LinearGradient.background.ignoresSafeArea()
//            
//            VStack {
//                Image.logoNontonID
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 20)
//                    .padding(8)
//                
//                Divider()
//                
//                ScrollView(showsIndicators: false) {
//                    Image(systemName: "person.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .padding()
//                        .background(LinearGradient.gradient)
//                        .foregroundColor(.primaryBackground)
//                        .frame(width: UIScreen.main.bounds.width / 5)
//                        .clipped()
//                        .cornerRadius(1000)
//                        .padding(.top)
//                    
//                    Group {
//                        TextField(
//                            LocalizableText.username.localized(viewModel.language),
//                            text: Binding(
//                                get: { (viewModel.user.value?.email).orEmpty() },
//                                set: { email in
//                                    if case .success(var user) = viewModel.user {
//                                        user.email = email
//                                        viewModel.user = .success(user)
//                                    }
//                                }
//                            )
//                        )
//                    }
//                    .textFieldStyle(.plain)
//                    .foregroundColor(.primaryText)
//                    .font(.title2.weight(.bold))
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal)
//                    .submitLabel(.done)
//                    .onSubmit {
//                        viewModel.changeUsername()
//                    }
//                    
//                    Text(verbatim: viewModel.email.orEmpty())
//                        .foregroundColor(.gray)
//                        .font(.body)
//                    
//                    
//                    VStack(alignment: .leading) {
//                        Text(LocalizableText.settings.localized(viewModel.language))
//                            .foregroundColor(.gray)
//                            .font(.body)
//                        
//                        Divider()
//                        NavigationLink {
//                            SettingsLanguageView()
//                        } label: {
//                            VStack {
//                                HStack {
//                                    Text(LocalizableText.language.localized(viewModel.language))
//                                        .foregroundColor(.primaryText)
//                                        .font(.headline)
//                                    
//                                    Spacer()
//                                }
//                                Divider()
//                            }
//                        }
//                        
//                        Toggle(isOn: $viewModel.isDarkMode.animation(.spring())) {
//                            Text(LocalizableText.darkTheme.localized(viewModel.language))
//                                .foregroundColor(.primaryText)
//                                .font(.headline)
//                        }
//                        
//                        Divider()
//                    }
//                    .padding()
//                    .padding(.vertical)
//                    
//                    Button {
//                        viewModel.showingAlert()
//                    } label: {
//                        Text(LocalizableText.logOut.localized(viewModel.language))
//                            .foregroundColor(.red)
//                            .font(.headline)
//                    }
//                    .alert(isPresented: $viewModel.showAlert) {
//                        Alert(
//                            title: Text(LocalizableText.logOutMainQuestion.localized(viewModel.language)),
//                            message: Text(LocalizableText.logOutDescription.localized(viewModel.language)),
//                            primaryButton: .destructive(Text(LocalizableText.yes.localized(viewModel.language)),
//                                                        action: {
//                                                            viewModel.logOut()
//                                                            tabSelection = 1
//                            }),
//                            secondaryButton: .cancel(Text(LocalizableText.cancel.localized(viewModel.language)))
//                        )
//                    }
//
//                }
//            }
//        }
//        .navigationTitle("")
//        .navigationBarHidden(false)
//        .onAppear {
//            viewModel.fetchUserData()
//        }
//        .onTapGesture {
//            hideKeyboard()
//        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(tabSelection: .constant(1))
    }
}
