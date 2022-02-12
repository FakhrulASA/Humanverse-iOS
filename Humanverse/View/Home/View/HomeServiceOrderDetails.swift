//
//  HomeServiceDetails.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/12/22.
//

import SwiftUI
import AlertToast
import PopupView

struct HomeServiceOrderDetails: View {
    var storageManager = OrderSubmitController()
    var calendar = Calendar.current
    @State var item: homeServiceListModel
    
    @State private var measurementList = ["Small", "Medium", "Large", "Extra large"]
    @State private var selectedMeasurementList = "Small"
    @State private var isExpandMeasurementList = false
    
    @State private var orderModelNo = ""
    @State private var orderAddress = ""
    @State private var orderDescription = ""
    @State private var orderDescriptionPlaceHolder = "Write description of product."
    @State private var orderMobileNo = ""
    @State private var estimatedCost = 0.0
    
    @State private var tempDate = Date()
    @State private var tempTime = Date()
    
    @State private var toastLoading = false
    @State private var toastSuccess = false
    @State private var toastError = false
    @State private var toastMessage = ""
    @State private var showProviderAlartPopupView = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        VStack{
                            VStack {
                                ImageWithURL(item.banner)
                                    .cornerRadius(12, corners: [.topLeft, .topRight])
                                    .shadow(radius: 5)
                                    .frame(height: 160)
                            }
                            
                            Text(item.serviceName).font(.system(size: 12)).bold().foregroundColor(.black)
                                .lineLimit(1)
                                .padding()
                        }
                        .background(.white)
                        .cornerRadius(12)
                        .shadow(radius: 12)
                        .padding([.leading, .trailing])
                        
                        VStack{
                            Text("Order detail's").font(.system(size: 16)).bold().foregroundColor(.black.opacity(0.5))
                                .lineLimit(1)
                                .padding()
                            
                            HStack {
                                Text("Measurement").font(.system(size: 12)).foregroundColor(.black)
                                    .padding(.leading)
                                    .frame(width: 100, alignment: .leading)
                                GroupBox {
                                    DisclosureGroup(self.selectedMeasurementList, isExpanded: $isExpandMeasurementList) {
                                        VStack{
                                            ForEach(self.measurementList.indices, id: \.self){ idx in
                                                let tempItem = self.measurementList[idx]
                                                Text("\(tempItem)").font(.system(size: 16)).foregroundColor(.black)
                                                    .padding()
                                                    .onTapGesture {
                                                        self.selectedMeasurementList = tempItem
                                                        estimatedCostCalculation(startingPrice: item.price, selectedPos: idx)
                                                        withAnimation{
                                                            self.isExpandMeasurementList.toggle()
                                                        }
                                                    }
                                            }
                                        }
                                    }
                                    .accentColor(.black)
                                    .font(.system(size: 16))
                                    .cornerRadius(8)
                                    
                                }.padding([.trailing, .bottom])
                                    .shadow(color: .purple,radius: 8)
                            }
                            
                            HStack {
                                Text("Model/SL No").font(.system(size: 12)).foregroundColor(.black)
                                    .padding(.leading)
                                    .frame(width: 100, alignment: .leading)
                                TextField("tesla m4/Gree 2TON 4e", text: $orderModelNo)
                                    .keyboardType(.default)
                                    .autocapitalization(.none)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color("field_color"), lineWidth: 2)
                                        
                                    ).padding([.trailing, .bottom])
                            }
                            
                            HStack {
                                Text("Date").font(.system(size: 12)).foregroundColor(.black)
                                    .padding(.leading)
                                    .frame(width: 100, alignment: .leading)
                                HStack {
                                    Spacer()
                                    DatePicker("", selection: $tempDate, displayedComponents: .date)
                                        .labelsHidden()
                                        .padding()
                                        .background(Color.white)
                                    Spacer()
                                    
                                }.overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("field_color"), lineWidth: 2)
                                    
                                ).padding([.trailing, .bottom])
                                    .padding(.leading, 3)
                            }
                            
                            HStack {
                                Text("Time").font(.system(size: 12)).foregroundColor(.black)
                                    .padding(.leading)
                                    .frame(width: 100, alignment: .leading)
                                
                                HStack {
                                    Spacer()
                                    DatePicker("", selection: $tempTime, displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                                        .padding()
                                        .background(Color.white)
                                    
                                    Spacer()
                                    
                                }.overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("field_color"), lineWidth: 2)
                                    
                                ).padding([.trailing, .bottom])
                                    .padding(.leading, 3)
                            }
                            
                            HStack {
                                Text("Address").font(.system(size: 12)).foregroundColor(.black)
                                    .padding(.leading)
                                    .frame(width: 100, alignment: .leading)
                                TextField("2/B NYC, USA", text: $orderAddress)
                                    .keyboardType(.default)
                                    .autocapitalization(.none)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color("field_color"), lineWidth: 2)
                                        
                                    ).padding([.trailing, .bottom])
                            }
                            
                            HStack {
                                Text("Description").font(.system(size: 12)).foregroundColor(.black)
                                    .padding(.leading)
                                    .frame(width: 100, alignment: .leading)
                                ZStack(alignment: .leading, content: {
                                    TextEditor(text: $orderDescription)
                                        .overlay(RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color("field_color"), lineWidth: 2))
                                        .frame(height: 100)
                                        .padding([.trailing, .bottom])
                                    if self.orderDescription.isEmpty {
                                        TextEditor(text: $orderDescriptionPlaceHolder)
                                            .padding(7)
                                            .foregroundColor(.gray)
                                            .disabled(true)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color("field_color"), lineWidth: 2))
                                            .frame(height: 100)
                                            .padding([.trailing, .bottom])
                                    }
                                })
                            }
                            
                            HStack {
                                Text("Mobile").font(.system(size: 12)).foregroundColor(.black)
                                    .padding(.leading)
                                    .frame(width: 100, alignment: .leading)
                                TextField("Enter your mobile number", text: $orderMobileNo)
                                    .keyboardType(.phonePad)
                                    .autocapitalization(.none)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color("field_color"), lineWidth: 2)
                                        
                                    ).padding([.trailing, .bottom])
                            }
                            
                            HStack{
                                Text("Estimated cost").font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .padding(.leading)
                                
                                Spacer()
                                Text("\(String(format: "%.2f", self.estimatedCost))$").font(.system(size: 18)).bold()
                                    .foregroundColor(.white)
                                    .padding(.leading)
                            }.padding()
                            .background(Color.purple)
                            
                        }.background(.white)
                            .cornerRadius(12)
                            .shadow(radius: 12)
                            .padding([.leading, .trailing, .top])
                    }
                    
                    Button(action: {
                        if self.orderModelNo.isEmpty {
                            self.toastMessage = "Model/SL no empty!"
                            self.toastError = true
                            return
                        }
                        
                        if self.orderAddress.isEmpty {
                            self.toastMessage = "Address field empty!"
                            self.toastError = true
                            return
                        }
                        
                        if self.orderDescription.isEmpty {
                            self.toastMessage = "Description field empty!"
                            self.toastError = true
                            return
                        }
                        
                        if self.orderMobileNo.count < 8 {
                            self.toastMessage = "Invalid mobile no!"
                            self.toastError = true
                            return
                        }
                        
                        orderSubmit()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("CONFIRM ORDER").font(.system(size: 18))
                                .foregroundColor(.white).bold()
                                .padding()
                            Spacer()
                            
                        }
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("field_color"), lineWidth: 2))
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color("field_color")))
                        .padding()
                    }).padding(.top, 50)
                })
                
            }.onAppear{
                estimatedCostCalculation(startingPrice: item.price, selectedPos: 0)
            }
        }.toast(isPresenting: $toastLoading){
            AlertToast(type: .loading, subTitle: "Loading")
        }.toast(isPresenting: $toastSuccess){
            AlertToast(type: .complete(Color(.green)), title: self.toastMessage)
        }.toast(isPresenting: $toastError){
            AlertToast(type: .error(Color(.red)), title: self.toastMessage)
        }
        
        .popup(isPresented: $showProviderAlartPopupView, type: .`default`, closeOnTap: false) {
            alartPopupView()
        }
    }
    
    func alartPopupView() -> some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack{
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 64, height: 64, alignment: .center)
                
                Text("Your request has been submitted, wait provider to contact you").font(.system(size: 16))
                    .lineLimit(3)
                    .foregroundColor(.white)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                HStack{
                    Spacer()
                    Button(action: {
                        self.showProviderAlartPopupView = false
                    }) {
                        Text("OKAY")
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
    
    private func estimatedCostCalculation(startingPrice: String,selectedPos: Int){
        let priceX: Double = (Double(startingPrice) ?? 0.0)/4
        if selectedPos == 0 {
            estimatedCost = Double(startingPrice) ?? 0.0
        } else if selectedPos == 1 {
            estimatedCost = (Double(startingPrice) ?? 0.0) + priceX
        }else if selectedPos == 2 {
            estimatedCost = (Double(startingPrice) ?? 0.0) + (priceX*2)
        }else if selectedPos == 3 {
            estimatedCost = (Double(startingPrice) ?? 0.0) + (priceX*3)
        }
    }
    
    private func orderSubmit(){
        self.toastLoading = true
        let hour = calendar.component(.hour, from: tempTime)
        let minutes = calendar.component(.minute, from: tempTime)
        storageManager.storeOrderSubmit(provider: item.email, price: String(self.estimatedCost), size: self.selectedMeasurementList, description: self.orderDescription, model: self.orderModelNo, address: self.orderAddress, time: "\(hour):\(minutes)", date: self.tempDate.formatDate(), serviceId: item.docID, status: "1", paidamount: "", userMobile: self.orderMobileNo, review: "", problem: "", serviceName: item.serviceName) { result in
            if result == 1 {
                self.toastLoading = false
                self.toastMessage = "Success!"
                self.toastSuccess = true
                
                self.selectedMeasurementList = "Small"
                self.orderModelNo = ""
                self.tempDate = Date.now
                self.tempTime = Date.now
                self.orderAddress = ""
                self.orderDescription = ""
                self.orderMobileNo = ""
                self.showProviderAlartPopupView = true
            } else {
                self.toastLoading = false
                self.toastMessage = "Something went wrong to submit order!"
                self.toastError = true
            }
        }
    }
}

struct HomeServiceOrderDetails_Previews: PreviewProvider {
    static var previews: some View {
        HomeServiceOrderDetails(item: homeServiceListModel(docID: "abcd", banner: "https://firebasestorage.googleapis.com:443/v0/b/humanverse-57f4d.appspot.com/o/service_banner%2Fmahmudurrahman2066@gmail.comcharities?alt=media&token=ca67141f-f207-4777-8b0b-e6277cfdc024", serviceName: "test charities", description: "Test Description", price: "100", country: "United States", state: "New York", city: "Bangla Town", serviceWebsite: "www.google.com", email: "abcd@example.com"))
    }
}
