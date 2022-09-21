//
//  ScanData.swift
//  billie
//
//  Created by Otávio Albuquerque on 08/09/22.
//

import Foundation

class TextItem: Identifiable {
    var id: String
    var text: String = ""
    
    init() {
        id = UUID().uuidString
    }
}


class RecognizedContent: ObservableObject {
    @Published var items = [TextItem]()
}

struct TabItem: Identifiable, Hashable, Equatable {
    var id = UUID()
    var name: String
    var quantity: Int
    var unitPrice: Double
    var totalPrice: Double {
        get { return Double(quantity ?? 0) * (unitPrice ?? 0)}
    }

}


class Tabs: ObservableObject {
    @Published var itemsTab = [TabItem]()
}
