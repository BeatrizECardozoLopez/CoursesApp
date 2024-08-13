//
//  Course.swift
//  Day9-Lists
//
//  Created by Beatriz Cardozo on 10/8/24.
//

import Foundation

struct Course: Identifiable{
    var id = UUID()
    var name : String
    var image : String
    var author: String
    var difficulty: Int
    var description : String
    var price: Float
    var isFavorite: Bool = false
    var isPurchased: Bool = false
}




