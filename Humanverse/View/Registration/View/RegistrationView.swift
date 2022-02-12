//
//  RegistrationView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 1/23/22.
//

import SwiftUI
import Firebase
import AlertToast
import PopupView

struct RegistrationView: View {
    @State private var userEmailAddress = ""
    @State private var userPassword = ""
    @State private var userConfirmPassword = ""
    @State private var userPhoneNo = ""
    @State private var showPassword = false
    @State private var showConPassword = false
    @State private var showVerifyEmailPopupView = false
    
    @State private var toastLoading = false
    @State private var toastSuccess = false
    @State private var toastError = false
    @State private var toastMessage = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                Image("img_reg_top").resizable()
                    .frame(height: 150)
            
                ScrollView {
                    VStack{
                        Text(Constants.REGISTRATION_TEXT).font(.largeTitle).bold().foregroundColor(Color("login_text_color"))
                        ZStack {
                            TextField("name@email.domain", text: $userEmailAddress)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("field_color"), lineWidth: 2)
                                    
                                ).padding()
                            HStack {
                                Text("Email Address").font(.system(size: 14)).foregroundColor(Color("field_color"))
                                    .padding([.leading, .trailing])
                                    .background(Color.white).padding(.bottom, 58)
                                    .padding([.leading,.trailing])
                                Spacer()
                            }.padding([.leading, .trailing])
                        }.padding([.leading, .trailing])
                        
                        if showPassword {
                            ZStack {
                                TextField("Password", text: $userPassword)
                                    .autocapitalization(.none)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color("field_color"), lineWidth: 2)
                                        
                                    ).padding()
                                HStack {
                                    Text("Password").font(.system(size: 14)).foregroundColor(Color("field_color"))
                                        .padding([.leading, .trailing])
                                        .background(Color.white).padding(.bottom, 58)
                                        .padding([.leading,.trailing])
                                    Spacer()
                                }.padding([.leading, .trailing])
                                
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        self.showPassword.toggle()
                                    }, label: {
                                        Image(showPassword ? "visibility" :  "invisible")
                                            .resizable()
                                            .frame(width: 20,height: 20)
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 30)
                                    })
                                }
                                
                            }.padding([.leading, .trailing])
                        } else {
                            ZStack {
                                SecureField("Password", text: $userPassword)
                                    .autocapitalization(.none)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color("field_color"), lineWidth: 2)
                                        
                                    ).padding()
                                HStack {
                                    Text("Password").font(.system(size: 14)).foregroundColor(Color("field_color"))
                                        .padding([.leading, .trailing])
                                        .background(Color.white).padding(.bottom, 58)
                                        .padding([.leading,.trailing])
                                    Spacer()
                                }.padding([.leading, .trailing])
                                
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        self.showPassword.toggle()
                                    }, label: {
                                        Image(showPassword ? "visibility" :  "invisible")
                                            .resizable()
                                            .frame(width: 20,height: 20)
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 30)
                                    })
                                }
                                
                            }.padding([.leading, .trailing])
                        }
                        
                        if showConPassword {
                            ZStack {
                                TextField("Password", text: $userConfirmPassword)
                                    .autocapitalization(.none)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color("field_color"), lineWidth: 2)
                                        
                                    ).padding()
                                HStack {
                                    Text("Confirm Password").font(.system(size: 14)).foregroundColor(Color("field_color"))
                                        .padding([.leading, .trailing])
                                        .background(Color.white).padding(.bottom, 58)
                                        .padding([.leading,.trailing])
                                    Spacer()
                                }.padding([.leading, .trailing])
                                
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        self.showConPassword.toggle()
                                    }, label: {
                                        Image(showConPassword ? "visibility" :  "invisible")
                                            .resizable()
                                            .frame(width: 20,height: 20)
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 30)
                                    })
                                }
                                
                            }.padding([.leading, .trailing])
                        } else {
                            ZStack {
                                SecureField("Password", text: $userConfirmPassword)
                                    .autocapitalization(.none)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color("field_color"), lineWidth: 2)
                                        
                                    ).padding()
                                HStack {
                                    Text("Confirm Password").font(.system(size: 14)).foregroundColor(Color("field_color"))
                                        .padding([.leading, .trailing])
                                        .background(Color.white).padding(.bottom, 58)
                                        .padding([.leading,.trailing])
                                    Spacer()
                                }.padding([.leading, .trailing])
                                
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        self.showConPassword.toggle()
                                    }, label: {
                                        Image(showConPassword ? "visibility" :  "invisible")
                                            .resizable()
                                            .frame(width: 20,height: 20)
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 30)
                                    })
                                }
                                
                            }.padding([.leading, .trailing])
                        }
                        
                        ZStack {
                            TextField("123456789", text: $userPhoneNo)
                                .keyboardType(.phonePad)
                                .autocapitalization(.none)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("field_color"), lineWidth: 2)
                                    
                                ).padding()
                            HStack {
                                Text("Mobile Number").font(.system(size: 14)).foregroundColor(Color("field_color"))
                                    .padding([.leading, .trailing])
                                    .background(Color.white).padding(.bottom, 58)
                                    .padding([.leading,.trailing])
                                Spacer()
                            }.padding([.leading, .trailing])
                        }.padding([.leading, .trailing])
                        
                        Button(action: {
                            if self.userEmailAddress.isEmpty {
                                self.toastMessage = "Enter valid email address!"
                                self.toastError = true
                                return
                            }
                            
                            if self.userPassword.isEmpty {
                                self.toastMessage = "Password field empty!"
                                self.toastError = true
                                return
                            }
                            
                            if self.userConfirmPassword.isEmpty {
                                self.toastMessage = "Confirm password field empty!"
                                self.toastError = true
                                return
                            }
                            
                            if self.userPassword != self.userConfirmPassword {
                                self.toastMessage = "Password not match!"
                                self.toastError = true
                                return
                            }
                            
                            if self.userPhoneNo.count < 8 {
                                self.toastMessage = "Phone number too short!"
                                self.toastError = true
                                return
                            }
                            
                            registrationWithEmail(userEmail: self.userEmailAddress, userPassword: self.userPassword, userPhoneNo: self.userPhoneNo)
                            
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Create Account").font(.system(size: 18))
                                    .foregroundColor(.white).bold()
                                    .padding()
                                
                                Spacer()
                                
                            }
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("field_color"), lineWidth: 2))
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color("field_color")))
                            .padding()
                            .padding([.leading, .trailing])
                        })
                        
                        
                        
                        Text("Already have HUMANVERSE account?").font(.system(size: 18)).foregroundColor(Color("login_text_color")).padding(.top, 50)
                        
                        Button(action: {
                            goLoginView()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Login Now").font(.system(size: 18))
                                    .foregroundColor(.white).bold()
                                    .padding()
                                
                                Spacer()
                                
                            }
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("field_color"), lineWidth: 2))
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color("field_color")))
                            .padding([.leading, .trailing])
                            .padding([.leading, .trailing])
                        })
                    }
                }
            }.ignoresSafeArea()
        }.toast(isPresenting: $toastLoading){
            AlertToast(type: .loading, subTitle: "Loading")
        }.toast(isPresenting: $toastSuccess){
            AlertToast(type: .complete(Color(.green)), title: self.toastMessage)
        }.toast(isPresenting: $toastError){
            AlertToast(type: .error(Color(.red)), title: self.toastMessage)
        }.popup(isPresented: $showVerifyEmailPopupView, type: .`default`, closeOnTap: false) {
            userEmailSendPopup()
        }
    }
    
    func userEmailSendPopup() -> some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack{
                Image(systemName: "scribble")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 64, height: 64, alignment: .center)
                
                Text("Verify Email Address!").font(.system(size: 18)).foregroundColor(.white).bold()
                
                Text("A verification email send to you given email address. Please verify email to login.").font(.system(size: 16))
                    .lineLimit(3)
                    .foregroundColor(.white)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                HStack{
                    Spacer()
                    Button(action: {
                        self.showVerifyEmailPopupView = false
                        logoutFirebaseAuth()
                        goLoginView()
                    }) {
                        Text("OK")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                    .frame(width: 100, height: 40)
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .padding(.leading, 20)
                }.padding(.top, 20)
            }.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                .frame(width: 350, height: 300)
                .background(Color("popup_bg"))
                .cornerRadius(10.0)
                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        }
    }
    
    //MARK: Auth registration with email and password
    private func registrationWithEmail(userEmail: String, userPassword: String, userPhoneNo: String){
        self.toastLoading = true
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (tempResult, tempError) in
            if tempError != nil {
                self.toastLoading = false
                self.toastMessage = tempError?.localizedDescription ?? "Unknown Error!"
                self.toastError = true
            } else {
                insertRegistrationData(userEmail: userEmail, userPhone: userPhoneNo)
            }
        }
    }
    
    //MARK: Firebase firestore new collection insertion for registration information
    private func insertRegistrationData(userEmail: String, userPhone: String){
        let docRef = db.collection("user").document(userEmail)
        docRef.setData(["mobile" : userPhone]){ error in
            if let error = error {
                self.toastLoading = false
                self.toastMessage = "Error to create account!"
                self.toastError = true
                print("Error to create account: \(error)")
            } else {
                self.toastLoading = false
                self.toastMessage = "Successfully create account!"
                self.toastSuccess = true
                sendEmailVerification()
            }
        }
    }
    
    private func sendEmailVerification(){
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            if let error = error {
                self.toastMessage = "Something went wrong to send verification email."
                self.toastError = true
                print("Error", error.localizedDescription)
            } else {
                self.showVerifyEmailPopupView = true
            }
        })
    }
    
    //MARK: Logout firebase auth
    private func logoutFirebaseAuth(){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
