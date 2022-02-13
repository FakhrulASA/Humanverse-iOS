//
//  PaymentSystemView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/14/22.
//

import SwiftUI

struct PaymentSystemView: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.1).ignoresSafeArea()
            VStack {
                ImageWithURL("https://1000logos.net/wp-content/uploads/2020/04/Google-Pay-Logo-2018.png")
                    .cornerRadius(12, corners: [.topLeft, .topRight])
                    .shadow(radius: 5)
                    .frame(width: 200,height: 120)
                
                Text("Paymen service development ongoing, please wait a while.")
                    .font(.title3)
                    .padding()
                    .multilineTextAlignment(.center)
                
            }
            .navigationBarTitle("Payment System")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PaymentSystemView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentSystemView()
    }
}
