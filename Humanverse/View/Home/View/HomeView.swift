//
//  HomeView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 1/26/22.
//

import SwiftUI

struct HomeView: View {
    @State private var optionList = [homeOptionListModel(optionID: 1, optionName: "Car Rent", optionKey: "carrental", optionImageName: "ic_car_rent"),
                                     homeOptionListModel(optionID: 2, optionName: "Car Wash", optionKey: "carwash", optionImageName: "ic_car_wash"),
                                     homeOptionListModel(optionID: 3, optionName: "Auto Repair", optionKey: "carrepair", optionImageName: "ic_auto_repair"),
                                     homeOptionListModel(optionID: 4, optionName: "Calender", optionKey: "calender", optionImageName: "ic_calender"),
                                     homeOptionListModel(optionID: 5, optionName: "Charities", optionKey: "charities", optionImageName: "ic_charities"),
                                     homeOptionListModel(optionID: 6, optionName: "AC Service", optionKey: "acrepair", optionImageName: "ic_ac_repair")]
    
    let layout = [GridItem(.flexible()),
                  GridItem(.flexible()),
                  GridItem(.flexible())]
    
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
                        LazyVGrid(columns: layout, spacing: 10) {
                            ForEach(self.optionList.indices, id: \.self){ idx in
                                let item = self.optionList[idx]
                                NavigationLink(destination: {
                                    HomeServicesView(searchName: item.optionName, searchKeys: item.optionKey)
                                }, label: {
                                    HomeOptionCell(item: item)
                                })
                                
                            }
                        }
                    }.padding([.leading, .trailing])
                    
                    NavigationLink(destination: {
                        HomeServicesView(searchName: "", searchKeys: "")
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
                }
            })
            
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
    @State private var imageSliderList = [homeImageSliderModel(sliderId: 1, sliderImageName: "img_banner_one"), homeImageSliderModel(sliderId: 2, sliderImageName: "img_banner_two")]
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
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 240)
                                .cornerRadius(12)
                                .shadow(radius: 5)
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
