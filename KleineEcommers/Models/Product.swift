//
//  Product.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import Foundation

struct Product: Identifiable, Codable {
    var id: Int
    var title: String
    var price: Double
    var discount: Double
    var image: String
    var isFavourite: Bool
    
    var formattedPrice: String {
        "$\(String(format: "%.0f", price))"
    }
    
    static var example: Product = Product(
        id: 1,
        title: "Pretty Chair",
        price: 1600, discount: 2000,
        image: "Furniture1",
        isFavourite: true
    )
    
    static var allProducts: [Product] = [
        Product(id: 2, title: "Chair 1", price: 1600, discount: 2000, image: "Furniture1", isFavourite: true),
        Product(id: 3, title: "Chair 2", price: 1600, discount: 2000, image: "Furniture2", isFavourite: false),
        Product(id: 4, title: "Chair 3", price: 1600, discount: 2000, image: "Furniture3", isFavourite: false),
        Product(id: 5, title: "Chair 4", price: 1600, discount: 2000, image: "Furniture4", isFavourite: true),
        Product(id: 6, title: "Chair 5", price: 1600, discount: 2000, image: "Furniture5", isFavourite: false)
    ]
}

class ProductViewModel: Identifiable, ObservableObject {
    private var product: Product
    
    @Published var isFavourite: Bool
    
    init(product: Product) {
        self.product = product
        isFavourite = product.isFavourite
    }
    
    
    var id: Int {
        product.id
    }
    
    var title: String {
        product.title
    }
    
    var image: String {
        product.image
    }
    
    var formattedPrice: String {
        "$\(String(format: "%.0f", product.price))"
    }
    
    var discount: String {
        "$" + product.price.clean
    }
    
    
}
