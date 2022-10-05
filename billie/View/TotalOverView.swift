//
//  TotalOverView.swift
//  billie
//
//  Created by Luciana Adrião on 19/09/22.
//
//  File currently not in use

import SwiftUI

struct TotalOverView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var totalPrice: Double
    @Binding var slideSuceeded: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .leading) {
                Group {
                    HStack{
                        Image(systemName: "person.fill")
                        Text("Total")
                        Spacer()
                        Text("R$ \(totalPrice, specifier: "%.2f")")
                    }
                    .font(Font.title3.bold())
                    HStack{
                        Image(systemName: "dollarsign.circle")
                        Text("10% Tip")
                        Spacer()
                        Text("R$ \(totalPrice*0.1, specifier: "%.2f")")
                    }
                    .foregroundColor(.secondary)
                    SliderButton(success: $slideSuceeded)
                        .frame(maxHeight: 70)
                        .padding([.bottom], 30)
                }
                .zIndex(0)
            }
            .ignoresSafeArea(.keyboard)
            .padding(.all, 20)
            Rectangle()
                .foregroundColor(colorScheme == .light ? Color(UIColor.white): Color(UIColor.systemGray6) )
                .shadow(radius: 4)
                .zIndex(-1)
        }
        .frame(height: UIScreen.main.bounds.height/9)

    }
}


struct TotalOverView_Previews: PreviewProvider {
    static var previews: some View {
        TotalOverView(totalPrice: 20, slideSuceeded: .constant(false))
    }
}
