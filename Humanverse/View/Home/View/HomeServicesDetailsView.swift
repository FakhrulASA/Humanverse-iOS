//
//  HomeServicesDetailsView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/12/22.
//

import SwiftUI

struct HomeServicesDetailsView: View {
    @State var item: homeServiceListModel
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack{
                        VStack(spacing: 8){
                            VStack {
                                ImageWithURL(item.banner)
                                    .cornerRadius(12, corners: [.topLeft, .topRight])
                                    .shadow(radius: 5)
                                    .frame(height: 160)
                            }
                            
                            HStack {
                                Image(systemName: "map").resizable()
                                    .foregroundColor(.purple)
                                    .frame(width: 16, height: 16, alignment: .center)
                                Text(item.country).font(.system(size: 12)).bold().foregroundColor(.black)
                                    .lineLimit(1)
                                    .padding(4)
                                
                                Spacer()
                                
                                Image(systemName: "mappin.and.ellipse").resizable()
                                    .foregroundColor(.purple)
                                    .frame(width: 16, height: 16, alignment: .center)
                                Text(item.state).font(.system(size: 12)).bold().foregroundColor(.black)
                                    .lineLimit(1)
                                    .padding(4)
                                
                                Spacer()
                                
                                Image(systemName: "building.2").resizable()
                                    .foregroundColor(.purple)
                                    .frame(width: 16, height: 16, alignment: .center)
                                Text(item.city).font(.system(size: 12)).bold().foregroundColor(.black)
                                    .lineLimit(1)
                                    .padding(4)
                            }.padding([.leading, .trailing, .bottom])
                            
                            Text(item.serviceName).font(.title2).foregroundColor(.black.opacity(0.7))
                                .bold()
                                .lineLimit(1)
                                .padding([.leading, .trailing, .bottom])
                            
                            Text(item.description).font(.system(size: 14)).foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding([.leading, .trailing, .bottom])
                            
                            HStack{
                                Text("Website:").font(.system(size: 14)).foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                Text(item.serviceWebsite).font(.system(size: 14)).foregroundColor(.blue)
                                    .underline()
                                    .multilineTextAlignment(.center)
                                Spacer()
                                    
                            }.padding([.leading, .trailing])
                            HStack{
                                Text("Contact:").font(.system(size: 14)).foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                Text(item.email).font(.system(size: 14)).foregroundColor(.blue)
                                    .underline()
                                    .multilineTextAlignment(.center)
                                Spacer()
                                    
                            }.padding([.leading, .trailing, .bottom])
                            
                            HStack{
                                Text("Price Starts from:").font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .padding(.leading)
                                
                                Spacer()
                                Text("\(item.price)$").font(.system(size: 18)).bold()
                                    .foregroundColor(.white)
                                    .padding(.leading)
                            }.padding()
                            .background(Color.purple)
                        }
                        .background(.white)
                        .cornerRadius(12)
                        .shadow(radius: 12)
                        .padding([.leading, .trailing])
                    }
                    
                    NavigationLink(destination: {
                        HomeServiceOrderDetails(item: item)
                    }, label: {
                        HStack {
                            Spacer()
                            Text("REQUEST SERVICE").font(.system(size: 16))
                                .foregroundColor(.white).bold()
                                .padding()
                            Spacer()
                            
                        }
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("field_color"), lineWidth: 2))
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color("field_color")))
                        .padding()
                    }).padding(.top, 50)
                })
            }
            .navigationBarTitle(item.serviceName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeServicesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeServicesDetailsView(item: homeServiceListModel(docID: "abcd", banner: "https://firebasestorage.googleapis.com:443/v0/b/humanverse-57f4d.appspot.com/o/service_banner%2Fmahmudurrahman2066@gmail.comcharities?alt=media&token=ca67141f-f207-4777-8b0b-e6277cfdc024", serviceName: "test charities", description: "Test Description", price: "100", country: "United States", state: "New York", city: "Bangla Town", serviceWebsite: "www.google.com", email: "abcd@example.com"))
    }
}
