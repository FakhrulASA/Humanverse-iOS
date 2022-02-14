//
//  ProfileView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 1/27/22.
//

import SwiftUI
import Firebase
import PopupView
import AlertToast
import StoreKit

struct ProfileView: View {
    @ObservedObject private var subscriberList = homeServiceList()
    @State private var image = UIImage()
    @State private var showSheet = false
    var storageManager = StorageManager()
    let storage = Storage.storage()
    
    @State private var showEditNamePopupView = false
    @State private var UserFullName = "User Name"
    
    @State private var showLogoutPopupView = false
    
    let db = Firestore.firestore()
    
    @State private var toastLoading = false
    @State private var toastSuccess = false
    @State private var toastError = false
    @State private var toastMessage = ""
    
    @State private var subscribeTimeLeft = ""
    @State private var showSubscribeTimeLeftPopup = false
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack {
                Rectangle()
                    .fill(Color("profile_header"))
                    .frame(height: 220)
                    .ignoresSafeArea()
                Spacer()
            }
            VStack{
                ZStack {
                    if self.image.ciImage == nil {
                        Image(uiImage: compressImage(image: self.image))
                            .resizable()
                            .cornerRadius(50)
                            .frame(width: 150, height: 150)
                            .background(Color("profile_header"))
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 8))
                        
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .cornerRadius(50)
                            .frame(width: 150, height: 150)
                            .background(Color("profile_header"))
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 8))
                    }
                    Image(systemName: "pencil")
                        .resizable()
                        .font(Font.system(size: 60, weight: .bold))
                        .frame(width: 24, height: 32, alignment: .center)
                        .foregroundColor(.white)
                        .padding([.leading, .bottom], 145)
                        .onTapGesture{
                            self.showSheet = true
                        }
                    
                }.padding(.top, 90)
                    .onAppear{
                        let storageRef = storage.reference().child("profile_pictures/\(Auth.auth().currentUser!.email ?? "not_found")")

                        storageRef.downloadURL { url, error in
                            if error != nil {
                                print("Error: Image could not download!")
                            } else {
                                URLSession.shared.dataTask(with: url!) { data, response, error in
                                    guard let data = data, let image = UIImage(data: data) else { return }
                                    RunLoop.main.perform {
                                        self.image = image
                                    }
                                }.resume()
                            }
                        }
                    }
                
                HStack {
                    Text("\(self.UserFullName)")
                    //.font(.system(size: 20))
                        .font(Font.title2)
                        .bold()
                        .foregroundColor(.black).opacity(0.8)
                    
                    Button(action: {
                        self.showEditNamePopupView = true
                    }, label: {
                        Image(systemName: "pencil")
                            .resizable()
                            .font(Font.system(size: 80, weight: .bold))
                            .frame(width: 24, height: 24, alignment: .center)
                            .foregroundColor(Color("profile_header"))
                    })
                }.padding(.top, 30)
                    .onAppear{
                        getUserNameFStore()
                    }
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack{
                        VStack(alignment: .center, spacing: 10, content: {
                            VStack {
                                NavigationLink(destination: {
                                    HelpCenterView()
                                }, label: {
                                    HStack{
                                        Image(systemName: "questionmark.circle.fill")
                                            .resizable()
                                            .foregroundColor(.gray)
                                            .frame(width: 40, height: 40, alignment: .center)
                                        Text("Help center")
                                            .font(Font.title3)
                                            .foregroundColor(.black).opacity(0.7)
                                            .padding(.leading, 20)
                                        Spacer()
                                    }
                                })
                                
                                Divider()
                                Button(action: {
                                    SKStoreReviewController.requestReviewInCurrentScene()
                                }, label: {
                                    HStack{
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .foregroundColor(.gray)
                                            .frame(width: 40, height: 40, alignment: .center)
                                        Text("Rate Humanverse")
                                            .font(Font.title3)
                                            .foregroundColor(.black).opacity(0.7)
                                            .padding(.leading, 20)
                                        Spacer()
                                    }
                                })
                                
                                Divider()
                                Button(action: {
                                    shareHumanVerse()
                                }, label: {
                                    HStack{
                                        Image("ic_share")
                                            .resizable()
                                            .foregroundColor(.gray)
                                            .frame(width: 40, height: 40, alignment: .center)
                                        Text("Share")
                                            .font(Font.title3)
                                            .foregroundColor(.black).opacity(0.7)
                                            .padding(.leading, 20)
                                        Spacer()
                                    }
                                })
                                
                                Divider()
                                Button(action: {
                                    self.showLogoutPopupView = true
                                }, label: {
                                    HStack{
                                        Image(systemName: "rectangle.portrait.and.arrow.right")
                                            .resizable()
                                            .foregroundColor(.gray)
                                            .frame(width: 40, height: 40, alignment: .center)
                                        Text("Log out")
                                            .font(Font.title3)
                                            .foregroundColor(.black).opacity(0.7)
                                            .padding(.leading, 20)
                                        Spacer()
                                    }
                                })
                                
                            }.padding()
                                .background()
                                .cornerRadius(8)
                                .shadow(radius: 8)
                            
                        }).padding()
                        
                        VStack(alignment: .center, spacing: 10, content: {
                            VStack {
                                HStack{
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .frame(width: 70, height: 70, alignment: .center)
                                        .foregroundColor(Color.yellow)
                                    
                                    VStack(alignment: .leading,spacing:10){
                                        Text("Membership status")
                                            .font(.system(size: 20))
                                            .bold()
                                            .foregroundColor(Color("membership_color"))
                                            .padding(.leading, 10)
                                        
                                        Text("Free Membership")
                                            .font(.system(size: 16))
                                            .foregroundColor(.black)
                                            .padding(.leading, 10)
                                        
                                        if self.subscriberList.subscriberList.count > 0 {
                                            Text("\(self.subscriberList.subscriberList[0].time)")
                                                .font(.system(size: 18))
                                                .bold()
                                                .foregroundColor(Color("profile_secondary_clr"))
                                                .padding(.leading, 10)
                                                .onAppear{
                                                    self.subscribeTimeLeft = self.subscriberList.subscriberList[0].time
                                                }
                                        } else {
                                            Text("0 day left")
                                                .font(.system(size: 18))
                                                .bold()
                                                .foregroundColor(Color("profile_secondary_clr"))
                                                .padding(.leading, 10)
                                        }
                                        
                                    }
                                    Spacer()
                                }
                                
//                                Text("Even with the free trial, it will help to let them know how much  it will  be  after the  trial, please add the following...").font(.system(size: 15)).foregroundColor(.black)
//                                    .multilineTextAlignment(.center)
                                Divider()
                                Text("You need to be a  member to  post, membership  is only $5/mo, No  other fees. Cancel  anytime, Apple pay or Google pay able to be a member here.").font(.system(size: 15)).foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                            }.padding()
                                .background()
                                .cornerRadius(8)
                            .shadow(radius: 8)
                            
                        }).padding()
                            .onAppear{
                                self.subscriberList.fetchSubscriberData()
                                self.showSubscribeTimeLeftPopup = true
                            }
                    }
                })
                
                Spacer()
            }
        }.sheet(isPresented: $showSheet){
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        .onChange(of: image) { img in
            storageManager.upload(image: img)
        }
        .popup(isPresented: $showEditNamePopupView, type: .`default`, closeOnTap: true) {
            userNameEditPopup()
        }.popup(isPresented: $showLogoutPopupView, type: .`default`, closeOnTap: false) {
            userLogoutPopup()
        }.popup(isPresented: $showSubscribeTimeLeftPopup, type: .`default`, closeOnTap: true) {
            userTimeoutPopup()
        }
        
        .toast(isPresenting: $toastLoading){
            AlertToast(type: .loading, subTitle: "Loading")
        }.toast(isPresenting: $toastSuccess){
            AlertToast(type: .complete(Color(.green)), title: self.toastMessage)
        }.toast(isPresenting: $toastError){
            AlertToast(type: .error(Color(.red)), title: self.toastMessage)
        }
    }
    
    func userNameEditPopup() -> some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack{
                Text("Edit Name").font(.system(size: 18)).foregroundColor(.white).bold()
                
                TextField("User Name", text: $UserFullName).font(.system(size: 16)).foregroundColor(.black).textFieldStyle(.roundedBorder)
                    .padding()
                
                HStack{
                    Spacer()
                    Button(action: {
                        storeNameFStore(editedName: self.UserFullName)
                    }) {
                        Text("Update")
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
    
    func userLogoutPopup() -> some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack{
                Image(systemName: "scribble")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 64, height: 64, alignment: .center)
                
                Text("Logout!").font(.system(size: 18)).foregroundColor(.white).bold()
                
                Text("Are you sure you want to logout?").font(.system(size: 16)).foregroundColor(.white).textFieldStyle(.roundedBorder)
                    .padding()
                
                HStack{
                    Spacer()
                    Button(action: {
                        self.showLogoutPopupView = false
                        logoutFirebaseAuth()
                        goLoginView()
                    }) {
                        Text("YES")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                    .frame(width: 100, height: 40)
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .padding(.leading, 20)
                    
                    Button(action: {
                        self.showLogoutPopupView = false
                    }) {
                        Text("NO")
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
    
    func userTimeoutPopup() -> some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack{
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 64, height: 64, alignment: .center)
                
                Text("Warning!").font(.system(size: 18)).foregroundColor(.white).bold()
                
                Text("Your trial membership only \(self.subscribeTimeLeft). Please renew to have access over 100's of services to provide and earn.").font(.system(size: 16)).foregroundColor(.white).textFieldStyle(.roundedBorder)
                    .lineLimit(4)
                    .padding()
                
                HStack{
                    Spacer()
                    Button(action: {
                        self.showSubscribeTimeLeftPopup = false
                    }, label: {
                        Text("  OKAY  ")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }).frame(width: 100, height: 40)
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .padding(.leading, 20)
                    
                    
                }.padding(.top, 20)
            }.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                .frame(width: 350, height: 350)
                .background(Color("popup_bg"))
                .cornerRadius(10.0)
                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        }
    }
    
    func compressImage(image: UIImage) -> UIImage {
        let resizedImage = image.aspectFittedToHeight(300)
        resizedImage.jpegData(compressionQuality: 0.2) // Add this line
        
        return resizedImage
    }
    
    func getUserNameFStore(){
        let docRef = db.collection("user").document(Auth.auth().currentUser!.email ?? "default user")
        docRef.getDocument { (returnDocument, returnError) in
            guard returnError == nil else{
                print("error", returnError ?? "")
                return
            }
            
            if let tempDoc = returnDocument, returnDocument!.exists {
                let data = tempDoc.data()
                if let data = data {
                    self.UserFullName = data["name"] as? String ?? "User Name"
                }
            }
        }
    }
    
    func storeNameFStore(editedName: String){
        self.toastLoading = true
        let docRef = db.collection("user").document(Auth.auth().currentUser?.email ?? "default@example.com")
        docRef.updateData(["name" : editedName]){ error in
            if let error = error {
                self.toastLoading = false
                self.toastMessage = "Error to update name!"
                self.toastError = true
                print("Error to update name: \(error)")
                self.showEditNamePopupView = false
            } else {
                self.toastLoading = false
                self.toastMessage = "Successfully update name!"
                self.toastSuccess = true
                self.UserFullName = editedName
                self.showEditNamePopupView = false
            }
        }
    }
    
    //MARK: Logout firebase auth
    private func logoutFirebaseAuth(){
        UserDefaultsManager().logOutUser()
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
    
    private func shareHumanVerse(){
        guard let data = URL(string: "https://sites.google.com/view/humanverse/home") else { return }
                let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
