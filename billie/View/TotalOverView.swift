//
//  TotalOverView.swift
//  billie
//
//  Created by Luciana Adrião on 19/09/22.
//

import SwiftUI

struct TotalOverView: View {
    
    var totalPrice: Double
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(Color(UIColor.systemBackground))
                .opacity(1).shadow(color: Color(UIColor.systemRed), radius: 2)
                .frame(maxHeight: UIScreen.main.bounds.height/5)
        }
        .overlay {
            VStack(alignment: .leading) {
                Group{
                    HStack{
                        Image(systemName: "person.fill")
                        Text("Total")
                        Spacer()
                        Text("R$ \(totalPrice, specifier: "%.2f")")
                    }
                    .font(Font.title3.bold())
                    Group {
                        HStack{
                            Image(systemName: "dollarsign.circle")
                            Text("10% Tip")
                            Spacer()
                            Text("R$ \(totalPrice*0.1, specifier: "%.2f")")
                        }
                    }
                    .foregroundColor(.secondary)
                }
                .padding(.all)
            }
        }
    }
}

struct TotalOverView_Previews: PreviewProvider {
    static var previews: some View {
        TotalOverView(totalPrice: 20)
    }
}
