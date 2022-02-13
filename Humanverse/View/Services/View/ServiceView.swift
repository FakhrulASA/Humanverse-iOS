//
//  ServiceView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 1/27/22.
//

import SwiftUI
import AlertToast

struct ServiceView: View {
    var storageManager = ServiceFirebaseHelper()
    //MARK: category dropdown
    @ObservedObject private var categoryList = homeServiceList()
    @State private var selectedCategoryName = "Select service"
    @State private var selectedCategoryKey = ""
    @State private var isExpandCategoryList = false
    
    //MARK: country drop down
    @State private var countryList = [countryListModel(countryName: "United States")]
    @State private var selectedCountryName = "Select Country"
    @State private var isExpandCountry = false
    
    //MARK: state drop down
    @State private var satateList = ["Alaska", "Alabama", "Arkansas", "American Samoa", "Arizona", "California", "Colorado", "Connecticut", "District of Columbia", "Delaware", "Florida", "Georgia", "Guam", "Hawaii", "Iowa", "Idaho", "Illinois", "Indiana", "Kansas", "Kentucky", "Louisiana", "Massachusetts", "Maryland", "Maine", "Michigan", "Minnesota", "Missouri", "Mississippi", "Montana", "North Carolina", "North Dakota", "Nebraska", "New Hampshire", "New Jersey", "New Mexico", "Nevada", "New York", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Puerto Rico", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Virginia", "Virgin Islands", "Vermont", "Washington", "Wisconsin", "West Virginia", "Wyoming"]
    @State private var selectedStateName = "Select state"
    @State private var isExpandState = false
    
    //MARK: form input textfields data holders
    @State private var serviceName = ""
    @State private var cityName = ""
    @State private var websiteName = ""
    @State private var servicePrice = ""
    @State private var serviceDetails = ""
    @State private var serviceDetailsPlaceHolder = "Describe your service"
    
    //MARK: image picker sheet open
    @State private var showImageSheet = false
    @State private var tempImageHolder = UIImage()
    
    //MARK: custom toast
    @State private var toastLoading = false
    @State private var toastSuccess = false
    @State private var toastError = false
    @State private var toastMessage = ""
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.02).ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack {
                    VStack {
                        HStack {
                            Text("Category").font(.system(size: 16)).foregroundColor(.black)
                                .padding(.leading)
                                .frame(width: 100, alignment: .leading)
                            GroupBox {
                                DisclosureGroup(self.selectedCategoryName, isExpanded: $isExpandCategoryList) {
                                    VStack{
                                        ForEach(self.categoryList.homeMenuCategoryList.indices, id: \.self){ idx in
                                            let item = self.categoryList.homeMenuCategoryList[idx]
                                            Text("\(item.title)").font(.system(size: 16)).foregroundColor(.black)
                                                .padding()
                                                .onTapGesture {
                                                    self.selectedCategoryName = item.title
                                                    self.selectedCategoryKey = item.name
                                                    withAnimation{
                                                        self.isExpandCategoryList.toggle()
                                                    }
                                                }
                                        }
                                    }
                                }.accentColor(.black)
                                    .font(.system(size: 16))
                                    .cornerRadius(8)
                                
                            }.padding([.trailing, .top, .bottom])
                                .shadow(color: .purple,radius: 8)
                                .onAppear{
                                    self.categoryList.fetchHomeMenuCategoryData()
                                }
                        }
                        
                        HStack {
                            Text("Name").font(.system(size: 16)).foregroundColor(.black)
                                .padding(.leading)
                                .frame(width: 100, alignment: .leading)
                            TextField("Enter your service name", text: $serviceName)
                                .keyboardType(.default)
                                .autocapitalization(.none)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("field_color"), lineWidth: 2)
                                    
                                ).padding([.trailing, .bottom])
                        }
                        
                        HStack {
                            Text("Country").font(.system(size: 16)).foregroundColor(.black)
                                .padding(.leading)
                                .frame(width: 100, alignment: .leading)
                            GroupBox {
                                DisclosureGroup(self.selectedCountryName, isExpanded: $isExpandCountry) {
                                    VStack{
                                        ForEach(self.countryList.indices, id: \.self){ idx in
                                            let item = self.countryList[idx]
                                            Text("\(item.countryName)").font(.system(size: 16)).foregroundColor(.black)
                                                .padding()
                                                .onTapGesture {
                                                    self.selectedCountryName = item.countryName
                                                    withAnimation{
                                                        self.isExpandCountry.toggle()
                                                    }
                                                }
                                        }
                                    }
                                }.accentColor(.black)
                                    .font(.system(size: 16))
                                    .cornerRadius(8)
                                
                            }.padding([.trailing, .bottom])
                                .shadow(color: .purple,radius: 8)
                        }
                        
                        HStack {
                            Text("State").font(.system(size: 16)).foregroundColor(.black)
                                .padding(.leading)
                                .frame(width: 100, alignment: .leading)
                            GroupBox {
                                DisclosureGroup(self.selectedStateName, isExpanded: $isExpandState) {
                                    ScrollView(.vertical, showsIndicators: false, content: {
                                        VStack{
                                            ForEach(self.satateList.indices, id: \.self){ idx in
                                                let item = self.satateList[idx]
                                                Text("\(item)").font(.system(size: 16)).foregroundColor(.black)
                                                    .padding()
                                                    .onTapGesture {
                                                        self.selectedStateName = item
                                                        withAnimation{
                                                            self.isExpandState.toggle()
                                                        }
                                                    }
                                            }
                                        }
                                    })
                                        .frame(height: 200)
                                }
                                .accentColor(.black)
                                .font(.system(size: 16))
                                .cornerRadius(8)
                                
                            }.padding([.trailing, .bottom])
                                .shadow(color: .purple,radius: 8)
                        }
                        HStack {
                            Text("City").font(.system(size: 16)).foregroundColor(.black)
                                .padding(.leading)
                                .frame(width: 100, alignment: .leading)
                            TextField("Enter your city name", text: $cityName)
                                .keyboardType(.default)
                                .autocapitalization(.none)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("field_color"), lineWidth: 2)
                                    
                                ).padding([.trailing, .bottom])
                        }
                        
                        HStack {
                            Text("Website").font(.system(size: 16)).foregroundColor(.black)
                                .padding(.leading)
                                .frame(width: 100, alignment: .leading)
                            TextField("Website/portfolio link", text: $websiteName)
                                .keyboardType(.default)
                                .autocapitalization(.none)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("field_color"), lineWidth: 2)
                                    
                                ).padding([.trailing, .bottom])
                        }
                        
                        HStack {
                            Text("Price").font(.system(size: 16)).foregroundColor(.black)
                                .padding(.leading)
                                .frame(width: 100, alignment: .leading)
                            TextField("Give your starting price", text: $servicePrice)
                                .keyboardType(.numberPad)
                                .autocapitalization(.none)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("field_color"), lineWidth: 2)
                                    
                                ).padding([.trailing, .bottom])
                        }
                        
                        HStack {
                            Text("Details").font(.system(size: 16)).foregroundColor(.black)
                                .padding(.leading)
                                .frame(width: 100, alignment: .leading)
                            ZStack(alignment: .leading, content: {
                                TextEditor(text: $serviceDetails)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color("field_color"), lineWidth: 2))
                                    .frame(height: 100)
                                    .padding([.trailing])
                                if self.serviceDetails.isEmpty {
                                    TextEditor(text: $serviceDetailsPlaceHolder)
                                        .padding(7)
                                        .foregroundColor(.gray)
                                        .disabled(true)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color("field_color"), lineWidth: 2))
                                        .frame(height: 100)
                                        .padding([.trailing])
                                    
                                }
                            })
                        }
                        
                        Button(action: {
                            self.showImageSheet = true
                        }, label: {
                            HStack {
                                Text("Image").font(.system(size: 16)).foregroundColor(.black)
                                    .padding(.leading)
                                    .frame(width: 100, alignment: .leading)
                                HStack {
                                    Spacer()
                                    Text("UPLOAD IMAGE").font(.system(size: 18))
                                        .foregroundColor(.white).bold()
                                        .padding()
                                    Spacer()
                                }
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("field_color"), lineWidth: 2))
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color("field_color")))
                                .padding()
                            }
                        })
                    }.background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 8)
                    
                    Button(action: {
                        if self.selectedCategoryKey == "" {
                            self.toastMessage = "Please select service category!"
                            self.toastError = true
                            return
                        }
                        
                        if self.serviceName.isEmpty {
                            self.toastMessage = "Please enter service name!"
                            self.toastError = true
                            return
                        }
                        
                        if self.selectedCountryName == "Select Country" {
                            self.toastMessage = "Please select country!"
                            self.toastError = true
                            return
                        }
                        
                        if self.selectedStateName == "Select state" {
                            self.toastMessage = "Please select state!"
                            self.toastError = true
                            return
                        }
                        
                        if self.cityName.isEmpty {
                            self.toastMessage = "Please enter city name!"
                            self.toastError = true
                            return
                        }
                        
//                        if self.websiteName.isEmpty {
//                            self.toastMessage = "Please website name!"
//                            self.toastError = true
//                            return
//                        }
                        
                        if self.servicePrice.isEmpty {
                            self.toastMessage = "Please enter starting price!"
                            self.toastError = true
                            return
                        }
                        
                        if self.serviceDetails.isEmpty {
                            self.toastMessage = "Please details of service!"
                            self.toastError = true
                            return
                        }
                        
                        if self.tempImageHolder.ciImage == nil && self.tempImageHolder.cgImage == nil {
                            self.toastMessage = "Please select an image!"
                            self.toastError = true
                            return
                        }
                            storeService()
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("REGISTER SERVICE").font(.system(size: 18))
                                .foregroundColor(.white).bold()
                                .padding()
                                .padding(.leading, 16)
                            Spacer()
                            Image(systemName: "arrow.right")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 16, height: 16, alignment: .center)
                                .padding(.trailing)
                        }
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("field_color"), lineWidth: 2))
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color("field_color")))
                        .padding()
                    }).padding(.top, 50)
                }.padding()
            }).navigationBarTitle("Add Service")
                .navigationBarTitleDisplayMode(.inline)
        }.sheet(isPresented: $showImageSheet){
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$tempImageHolder)
        }
        .toast(isPresenting: $toastLoading){
            AlertToast(type: .loading, subTitle: "Loading")
        }.toast(isPresenting: $toastSuccess){
            AlertToast(type: .complete(Color(.green)), title: self.toastMessage)
        }.toast(isPresenting: $toastError){
            AlertToast(type: .error(Color(.red)), title: self.toastMessage)
        }
    }
    
    private func storeService(){
        self.toastLoading = true
        storageManager.upload(image: self.tempImageHolder, serviceName: self.selectedCategoryKey) { data in
            if data == 1 {
                storageManager.getImagePath(serviceName: self.selectedCategoryKey) { data in
                    if data != ""{
                        storageManager.storeService(serviceName: self.serviceName, serviceCategory: self.selectedCategoryKey, countryName: self.selectedCountryName, stateName: self.selectedStateName, cityName: self.cityName, description: self.serviceDetails, servicePrice: self.servicePrice, bannerUrl: data, serviceWebsite: self.websiteName) { result in
                            if result == 1 {
                                self.toastLoading = false
                                self.toastMessage = "Success!"
                                self.toastSuccess = true
                                
                                self.selectedCategoryName = "Select service"
                                self.selectedCategoryKey = ""
                                self.serviceName = ""
                                self.selectedCountryName = "Select Country"
                                self.selectedStateName = "Select state"
                                self.cityName = ""
                                self.websiteName = ""
                                self.servicePrice = ""
                                self.serviceDetails = ""
                                self.tempImageHolder = UIImage()
                                
                            } else {
                                self.toastLoading = false
                                self.toastMessage = "Something went wrong to add service!"
                                self.toastError = true
                            }
                        }
                    } else {
                        self.toastLoading = false
                        self.toastMessage = "Image not found in server!"
                        self.toastError = true
                    }
                }
            } else {
                self.toastLoading = false
                self.toastMessage = "Image upload failed!"
                self.toastError = true
            }
        }
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
    }
}
