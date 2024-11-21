//
//  SignIn.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/13/24.
//

import SwiftUI

struct SignIn: View {
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.dismiss) var goBack
    // @StateObject var authManager = AuthManager()
    @StateObject var registerVM = SignUpViewModel()
    @State private var showPassword: Bool = false
    @State private var showConfirmPassword: Bool = false
    @State private var showContent: Bool = false
    @State private var confirmPassword = ""
    @State private var isLoading: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                Header(
                    action: {
                        goBack()
                    },
                    headerTitle: "uzimmie",
                    subTitle: showContent ? "Register" : "Log In",
                    icon: "arrow.left"
                )
                Spacer()
                 Text(showContent ? "Sign up" : "Log in")
                if !authManager.errorMessage.isEmpty {
                    Text(authManager.errorMessage)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(Color.red)
                }
                
                // MARK: - Sign Up Section
                if showContent {
                    HStack {
                        Image(systemName: "person.fill")
                        TextField("First Name", text: $registerVM.firstName)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }
                    .padding()
                    .overlay(Capsule().fill(.clear).border(Color.black, width: 1))
                    .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: "person.fill")
                        TextField("Sir Name", text: $registerVM.lastName)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }
                    .padding()
                    .overlay(Capsule().fill(.clear).border(Color.black, width: 1))
                    .padding(.horizontal)
                
                    HStack {
                        Image(systemName: "envelope")
                        TextField("Email", text: $registerVM.email)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }
                    .padding()
                    .overlay(Capsule().fill(.clear).border(Color.black, width: 1))
                    .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                        if showPassword {
                            TextField("Password", text: $registerVM.password)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                        } else {
                            SecureField("Password", text: $registerVM.password)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                        }
                        
                        Button {
                            showPassword.toggle()
                        } label: {
                            Image(systemName: showPassword ? "eyes" : "eyebrow")
                        }
                        .foregroundStyle(.black)
                    }
                    .padding()
                    .overlay(Capsule().fill(.clear).border(Color.black, width: 1))
                    .padding(.horizontal)
                    // confirm password
                    HStack {
                        Image(systemName: "lock.fill")
                        if showConfirmPassword {
                            TextField("Confirm Password", text: $confirmPassword)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                        } else {
                            SecureField("Confirm Password", text: $confirmPassword)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                        }
                        
                        Button {
                            showConfirmPassword.toggle()
                        } label: {
                            Image(systemName: showConfirmPassword ? "eyes" : "eyebrow")
                        }
                        .foregroundStyle(.black)
                    }
                    .padding()
                    .overlay(Capsule().fill(.clear).border(Color.black, width: 1))
                    .padding(.horizontal)
                    
                    // redirect section / Links
                    HStack(spacing: 0) {
                        Text("Have an account?")
                            .font(.footnote)
                            .padding(.leading)
                            .onTapGesture {
                                showContent = false
                            }
                        Text("Sign in")
                            .font(.footnote)
                            .underline()
                            .padding(.leading)
                            .onTapGesture {
                                showContent = false
                            }
                        Spacer()
                    }
                } else {
                    // MARK: - Sign in Section
                    VStack {
                        HStack {
                            Image(systemName: "envelope")
                            TextField(showContent ? "Username" : "Email", text: $authManager.email)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                        }
                        .padding()
                        .overlay(Capsule().fill(.clear).border(Color.black, width: 1))
                        .padding(.horizontal)
                        
                        // Password
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "lock.fill")
                                if showPassword {
                                    TextField("Password", text: $authManager.password)
                                        .keyboardType(.emailAddress)
                                        .autocorrectionDisabled()
                                        .textInputAutocapitalization(.never)
                                } else {
                                    SecureField("Password", text: $authManager.password)
                                        .keyboardType(.emailAddress)
                                        .autocorrectionDisabled()
                                        .textInputAutocapitalization(.never)
                                }
                                
                                Button {
                                    showPassword.toggle()
                                } label: {
                                    Image(systemName: showPassword ? "eyes" : "eyebrow")
                                }
                                .foregroundStyle(.black)
                            }
                            .padding()
                            .overlay(Capsule().fill(.clear).border(Color.black, width: 1))
                            .padding(.horizontal)
                            
                            // trouble signing in
                            Text("Trouble signing in")
                                .font(.footnote)
                                .underline()
                                .padding(.leading)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // MARK: - Sign in button
                if showContent == false {
                    CustomSolidButton(
                        action: signIn,
                        buttonTitle: "Sign in",
                        foregroundColor: .black,
                        backgroundColor: .orange,
                        icon: ""
                    )
                }
                
                // MARK: - Sign up button
                if showContent {
                    CustomSolidButton(
                        action: {
                            registerVM.signUp()
                        },
                        buttonTitle: "Sign up",
                        foregroundColor: .orange,
                        backgroundColor: .black,
                        icon: "person.fill"
                    )
                    
                    Text("Go Back From Which You Came")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .underline()
                        .onTapGesture {
                            goBack()
                        }
                    
                } else {
                    Button {
                        withAnimation(.easeInOut) {
                            showContent.toggle()
                        }
                    } label: {
                        Text("Register an Account")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .underline()
                    }
                    .foregroundStyle(.black)
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationBarBackButtonHidden(true)
        }
        .background()
        .environment(\.colorScheme, .light)
    }
    
    private func signIn() {
            isLoading = true
            authManager.signIn(email: authManager.email, password: authManager.password) { result in
                isLoading = false
                switch result {
                case .success:
                    print("User signed in successfully")
                    // Perform any necessary actions after successful sign-in
                case .failure(let error):
                    authManager.errorMessage = error.localizedDescription
                }
            }
        }
}

#Preview {
    SignIn()
}
