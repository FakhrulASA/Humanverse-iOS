//
//  ResetPasswordView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/12/22.
//

import SwiftUI
import AlertToast
import Firebase

struct ResetPasswordView: View {
    @State private var userEmailAddress = ""
    @State private var showNotifyPopupView = false
    
    @State private var toastLoading = false
    @State private var toastSuccess = false
    @State private var toastError = false
    @State private var toastMessage = ""
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                Image("img_login_header").resizable()
                    .frame(height: 280)
                
                ScrollView {
                    VStack {
                        Text("Reset Password").font(.title3).bold().foregroundColor(Color("login_text_color"))
                        
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
                        
                        Button(action: {
                            if self.userEmailAddress.isEmpty {
                                self.toastMessage = "Email field blank!"
                                self.toastError = true
                                return
                            }
                            requestResetPassword(emailAddress: self.userEmailAddress)
                        }, label: {
                            HStack {
                                Spacer()
                                Text("RESET").font(.system(size: 18))
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
        }.popup(isPresented: $showNotifyPopupView, type: .`default`, closeOnTap: false) {
            userResetPasswordPopup()
        }
    }
    
    private func requestResetPassword(emailAddress: String){
        self.toastLoading = true
        Auth.auth().sendPasswordReset(withEmail: emailAddress) { error in
            if let error = error {
                self.toastLoading = false
                self.toastMessage = "Something went wrong!"
                self.toastError = true
                print("Error to Submit help request: \(error)")
            } else {
                self.toastLoading = false
                self.toastMessage = "Success!"
                self.toastSuccess = true
                
                self.showNotifyPopupView = true
            }
        }
    }
    
    func userResetPasswordPopup() -> some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack{
                Image(systemName: "scribble")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 64, height: 64, alignment: .center)
                
                Text("Reset Password!").font(.system(size: 18)).foregroundColor(.white).bold()
                
                Text("An email send to you given email address. Please check email to reset password.").font(.system(size: 16))
                    .lineLimit(3)
                    .foregroundColor(.white)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                HStack{
                    Spacer()
                    Button(action: {
                        self.showNotifyPopupView = false
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
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
