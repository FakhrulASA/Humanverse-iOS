//
//  HistoryProgressView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/12/22.
//

import SwiftUI

struct HistoryProgressView: View {
    @State var tempItem: historyList
    var body: some View {
        ZStack {
            Color.gray.opacity(0.02).ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    VStack(alignment: .center, spacing: 5, content: {
                        HStack {
                            Spacer()
                            Text("\(tempItem.serviceName)").font(.system(size: 16)).bold()
                                .foregroundColor(.white)
                            .padding()
                            Spacer()
                        }
                        HStack {
                            Text("Estimated completion date: \(tempItem.date) \(tempItem.time)")
                                .font(.system(size: 14)).foregroundColor(.white)
                            .padding([.leading, .trailing])
                            Spacer()
                        }
                        HStack {
                            Text("ORDER ID: \(tempItem.docId)")
                                .font(.system(size: 14)).bold().foregroundColor(.white)
                                .padding([.leading, .trailing, .bottom])
                            Spacer()
                        }
                    }).background(Color.purple)
                        .cornerRadius(8)
                        .shadow(radius: 8)
                        .padding([.leading, .trailing, .top])
                    
                    Text("Service in progress...").font(.title3).padding()
                    
                    HStack(spacing: 0){
                        Divider()
                            .frame(width: 3, height: 120)
                            .background(Color.purple)
                        VStack (alignment: .leading){
                            HStack(spacing: 2) {
                                VStack{
                                        Divider()
                                        .frame(width: 30, height: 3)
                                        .background(Color.purple)
                                }
                                if self.tempItem.status == 1 {
                                    Text("Order Pending").font(.system(size: 14)).foregroundColor(.purple)
                                } else {
                                    Text("Order Pending").font(.system(size: 14)).foregroundColor(.black)
                                }
                                
                            }
                            HStack(spacing: 2) {
                                VStack{
                                        Divider()
                                        .frame(width: 30, height: 3)
                                        .background(Color.purple)
                                }
                                if self.tempItem.status == 2 {
                                    Text("Order Confirmmed").font(.system(size: 14)).foregroundColor(.purple)
                                } else {
                                    Text("Order Confirmmed").font(.system(size: 14)).foregroundColor(.black)
                                }
                            }
                            
                            HStack(spacing: 2) {
                                VStack{
                                        Divider()
                                        .frame(width: 30, height: 3)
                                        .background(Color.purple)
                                }
                                if self.tempItem.status == 3 {
                                    Text("Order Completed").font(.system(size: 14)).foregroundColor(.purple)
                                } else {
                                    Text("Order Completed").font(.system(size: 14)).foregroundColor(.black)
                                }
                            }
                            
                            HStack(spacing: 2) {
                                VStack{
                                        Divider()
                                        .frame(width: 30, height: 3)
                                        .background(Color.purple)
                                }
                                
                                if self.tempItem.status == 4 {
                                    Text("Payment Completed").font(.system(size: 14)).foregroundColor(.purple)
                                } else {
                                    Text("Payment Completed").font(.system(size: 14)).foregroundColor(.black)
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        let supportEmail = tempItem.provider
                        if let url = URL(string: "mailto:\(supportEmail)") {
                          if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url)
                          } else {
                            UIApplication.shared.openURL(url)
                          }
                        }
                    }, label: {
                        HStack {
                            Spacer()
                            Text("CONTACT PROVIDER").font(.system(size: 16))
                                .foregroundColor(.white).bold()
                                .padding()
                            Spacer()
                            
                        }
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("field_color"), lineWidth: 2))
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color("field_color")))
                        .padding()
                    }).padding(.top, 100)
                }
            })
                .navigationBarTitle("Order Progress")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HistoryProgressView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryProgressView(tempItem: historyList(docId: "abcd", serviceName: "service name", price: "100", date: "14/02/2022", time: "20:30", provider: "abcd@example.com", status: 1))
    }
}
