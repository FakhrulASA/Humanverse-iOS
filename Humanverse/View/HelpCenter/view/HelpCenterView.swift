//
//  HelpCenterView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/11/22.
//

import SwiftUI
import Firebase
import AlertToast

struct HelpCenterView: View {
    @State private var helpSubject = ""
    @State private var helpDescription = ""
    @State private var helpDescriptionPlaceHolder = "Description"
    let db = Firestore.firestore()
    
    @State private var toastLoading = false
    @State private var toastSuccess = false
    @State private var toastError = false
    @State private var toastMessage = ""
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    TextField("Subject", text: $helpSubject)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("field_color"), lineWidth: 2)
                            
                        ).padding()
                    
                    ZStack(alignment: .leading, content: {
                        TextEditor(text: $helpDescription)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("field_color"), lineWidth: 1))
                            .frame(height: 100)
                            .padding([.leading, .trailing])
                        if self.helpDescription.isEmpty {
                            TextEditor(text: $helpDescriptionPlaceHolder)
                                .padding(7)
                                .foregroundColor(.gray)
                                .disabled(true)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("field_color"), lineWidth: 1))
                                .frame(height: 100)
                                .padding([.leading, .trailing])
                                
                        }
                    })
                    
                    Text("You will be notified with a email within 2-4 working days. Thank you for contacting us.")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        if self.helpSubject.isEmpty {
                            self.toastMessage = "Blank subject field!"
                            self.toastError = true
                            return
                        } else if self.helpDescription.isEmpty {
                            self.toastMessage = "Blank description field!"
                            self.toastError = true
                            return
                        } else {
                            submitHelpCenterRequest(formSubject: self.helpSubject, formDescription: self.helpDescription)
                        }
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Submit Request").font(.system(size: 18))
                                .foregroundColor(.white).bold()
                                .padding()
                            
                            Spacer()
                            
                        }
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("field_color"), lineWidth: 2))
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color("field_color")))
                        .padding()
                        .padding([.leading, .trailing])
                    })
                }
            })
                .navigationBarTitle("Help Center")
                .navigationBarTitleDisplayMode(.inline)
        }
        .toast(isPresenting: $toastLoading){
            AlertToast(type: .loading, subTitle: "Loading")
        }.toast(isPresenting: $toastSuccess){
            AlertToast(type: .complete(Color(.green)), title: self.toastMessage)
        }.toast(isPresenting: $toastError){
            AlertToast(type: .error(Color(.red)), title: self.toastMessage)
        }
    }
    
    private func submitHelpCenterRequest(formSubject: String, formDescription: String){
        self.toastLoading = true
        let docRef = db.collection("helpcenter").document(Auth.auth().currentUser?.email ?? "default@example.com")
        docRef.setData(["subject" : formSubject, "problem description" : formDescription]){ error in
            if let error = error {
                self.toastLoading = false
                self.toastMessage = "Something went wrong to submit request!"
                self.toastError = true
                print("Error to Submit help request: \(error)")
            } else {
                self.toastLoading = false
                self.toastMessage = "Successfully update name!"
                self.toastSuccess = true
                self.helpSubject = ""
                self.helpDescription = ""
            }
        }
    }
}

struct HelpCenterView_Previews: PreviewProvider {
    static var previews: some View {
        HelpCenterView()
    }
}
