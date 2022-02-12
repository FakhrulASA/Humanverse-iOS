//
//  ServiceMainView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/12/22.
//

import SwiftUI
import PopupView

struct ServiceMainView: View {
    @ObservedObject private var serviceList = wonServiceList()
    @State private var showWarningPopupView = false
    var body: some View {
        ZStack {
            Color.gray.opacity(0.02).ignoresSafeArea()
            VStack {
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 10){
                        ForEach(self.serviceList.wonServicesList.indices, id: \.self){ idx in
                            let item = self.serviceList.wonServicesList[idx]
                            WonServiceCellView(item: item)
                                .padding([.leading, .trailing])
                                .onTapGesture{
                                    self.showWarningPopupView = true
                                }
                        }
                    }.onAppear{
                        self.serviceList.fetchData()
                    }
                }
            }
            VStack{
                Spacer()
                NavigationLink(destination: {
                    ServiceView()
                }, label: {
                    HStack {
                        Spacer()
                        Text("ADD SERVICE").font(.system(size: 12))
                            .foregroundColor(.white).bold()
                            .padding()
                            .padding(.leading, 5)
                        Spacer()
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 16, height: 16, alignment: .center)
                            .padding(.trailing)
                    }.frame(width: 170)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("field_color"), lineWidth: 2))
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color("field_color")))
                    .padding()
                })
            }
        }
        .popup(isPresented: $showWarningPopupView, type: .`default`, closeOnTap: true) {
            userWarningPopup()
        }
    }
    
    func userWarningPopup() -> some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack{
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 64, height: 64, alignment: .center)
                
                Text("Warning!").font(.system(size: 18)).foregroundColor(.white).bold()
                
                Text("To manage your services, please download our Humanverse Service Application.").font(.system(size: 16)).foregroundColor(.white).textFieldStyle(.roundedBorder)
                    .padding()
                
                HStack{
                    Spacer()
                    Button(action: {
                        self.showWarningPopupView = false
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
}

struct ServiceMainView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceMainView()
    }
}
