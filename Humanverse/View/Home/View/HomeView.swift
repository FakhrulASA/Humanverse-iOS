//
//  HomeView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 1/26/22.
//

import SwiftUI
import AlertToast
import PopupView

struct HomeView: View {
    
    @ObservedObject private var menuList = homeServiceList()
    @State private var toastLoading = false
    @State private var toastSuccess = false
    @State private var toastError = false
    @State private var toastMessage = ""
    
    let layout = [GridItem(.flexible()),
                  GridItem(.flexible()),
                  GridItem(.flexible())]
    
    @State private var subscribeTimeLeft = ""
    @State private var showSubscribeTimeLeftPopup = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    VStack{
                        SliderView()
                            .padding(.top, 20)
                            .cornerRadius(12)
                            .shadow(radius: 8)
                    }
                    HStack {
                        Text("Available Services Category").font(.system(size: 20)).bold().foregroundColor(Color("clr_home_subject_line"))
                        Spacer()
                    }.padding([.leading, .trailing])
                    
                    VStack{
                        if self.menuList.homeMenuCategoryList.count > 5 {
                            LazyVGrid(columns: layout, spacing: 10) {
                                ForEach(0..<6){ idx in
                                    let item = self.menuList.homeMenuCategoryList[idx]
                                    NavigationLink(destination: {
                                        HomeServicesView(searchName: item.title, searchKeys: item.name)
                                    }, label: {
                                        HomeOptionCell(item: item)
                                    })

                                }
                            }
                        } else {
                            LazyVGrid(columns: layout, spacing: 10) {
                                ForEach(self.menuList.homeMenuCategoryList.indices, id: \.self){ idx in
                                    let item = self.menuList.homeMenuCategoryList[idx]
                                    NavigationLink(destination: {
                                        HomeServicesView(searchName: item.title, searchKeys: item.name)
                                    }, label: {
                                        HomeOptionCell(item: item)
                                    })

                                }
                            }
                        }
                        
                    }.padding([.leading, .trailing])
                        .onAppear{
                            self.toastLoading = true
                            self.menuList.fetchHomeMenuCategoryData()
                            self.toastLoading = false
                            
                        }
                    
                    if self.menuList.subscriberList.count > 0 {
                        Text("\(self.menuList.subscriberList[0].time)")
                            .font(.system(size: 18))
                            .bold()
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                            .onAppear{
                                self.subscribeTimeLeft = self.menuList.subscriberList[0].time
                            }
                    } else {
                        Text("0 day left")
                            .font(.system(size: 18))
                            .bold()
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                    }
                    
                    NavigationLink(destination: {
                        AllServiceCategoryView()
                    }, label: {
                        HStack(alignment: .center, spacing: 5, content: {
                            Spacer()
                            Text("SEE ALL SERVICE")
                                .foregroundColor(.white).bold()
                            Spacer()
                    }).padding()
                            .background(Color("button_bg"))
                            .cornerRadius(8)
                            .padding([.leading, .trailing, .top])
                            .shadow(radius: 8)
                            
                    
                    })
                }.onAppear{
                    self.menuList.fetchSubscriberData()
                    self.showSubscribeTimeLeftPopup = true
                }
            })
            
        }.toast(isPresenting: $toastLoading){
            AlertToast(type: .loading, subTitle: "Loading")
        }.toast(isPresenting: $toastSuccess){
            AlertToast(type: .complete(Color(.green)), title: self.toastMessage)
        }.toast(isPresenting: $toastError){
            AlertToast(type: .error(Color(.red)), title: self.toastMessage)
        }.popup(isPresented: $showSubscribeTimeLeftPopup, type: .`default`, closeOnTap: true) {
            userTimeoutPopup()
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//For Image Slider
struct SliderView: View {
    @State private var imageSliderList = [homeImageSliderModel(sliderId: 3, sliderImageName: "img_banner_three")]
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .white
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.red.withAlphaComponent(0.2)
    }
    
    func next() {
        withAnimation{
            currentIndex = currentIndex < self.imageSliderList.count ? currentIndex + 1 : 0
        }
    }
    
    var body: some View {
        ZStack {
            if self.imageSliderList.count > 0 {
                TabView(selection: $currentIndex) {
                    ForEach(self.imageSliderList.indices, id: \.self) { idx in
                        VStack{
                            Image(self.imageSliderList[idx].sliderImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 240)
                                .cornerRadius(12)
                                .shadow(radius: 12)
                                .padding([.leading, .trailing])
                                .onTapGesture{
                                    if let url = URL(string: "https://21c5b6k6p9-8wjnh9ec3bl0y3j.hop.clickbank.net/") {
                                           UIApplication.shared.open(url)
                                        }
                                }
                        }
                    }
                }
                .frame(height: 200)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .onReceive(timer, perform: { _ in
                    next()
                })
            }
        }
    }
}
