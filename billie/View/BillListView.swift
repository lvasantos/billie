//
//  BillListView.swift
//  billie
//
//  Created by Otávio Albuquerque on 13/09/22.
//

import SwiftUI

struct BillListView: View {
    @State private var slide = 50.0
    @State private var isEditing = false
    @State var tabs = Tabs()
    
    let alignment: Alignment = .bottom
    let width: CGFloat = 0.0
    let height: CGFloat = 0.0
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    
    @Binding var items: [TabItem]
    
    var sumOfAllItems: Double {
        let totalPrices = items.map(\.totalPrice)
        return totalPrices.reduce(0, +)
    }
    
    @StateObject var newTab = Tabs()
    
    var body: some View {
        NavigationView{
            VStack{
                
                List {
                    Section{
                        Button {
                            // Takes to the data saved
                            // The photo taken if possible, otherwise take the header off. =D
                        } label: {
                            HStack {
                                Text("Your tab")
                                Spacer()
                                Image(systemName: "photo")
                            }
                        }.padding([.leading,.trailing])
                        
                    } header: {
                        Text("successfully scanned, you can modify your tab below")
                            .font(.subheadline)
                            .listRowBackground(Color(.clear))
                            .listRowSeparator(.hidden)
                            .foregroundColor(.secondary)
                        
                    }.headerProminence(.increased)
                    
                    
                    ForEach($items, id: \.self) { $item in
                        billListRow(item: item.name, quantity: $item.quantity, unitPrice: item.unitPrice)
                    }
                    .onDelete(perform: removeItems)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.grouped)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Resume Tabs")
                .toolbar {
                    ToolbarItem (placement: .navigationBarTrailing) {
                        Button {
                        } label: {
                            Text("Edit")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            let newItem = TabItem(name: "random", quantity: 2, unitPrice: 2.0)
                            items.append(newItem)
                        } label: {
                            Image(systemName: "text.badge.plus")
                        }
                    }
                }
                TotalOverView(totalPrice: sumOfAllItems)
            }
            
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

//struct BillListView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//    @State var items: [TabItem] = [
//        TabItem(name: "AGUACATE", quantity: 2, unitPrice: 5),
//        TabItem(name: "VVatermelon", quantity: 1, unitPrice: 5),
//        TabItem(name: "EarthMelon", quantity: 1, unitPrice: 5),
//        TabItem(name: "Firemelon", quantity: 1, unitPrice: 5),
//        TabItem(name: "Airmelon", quantity: 1, unitPrice: 5)
//    ]
//}

