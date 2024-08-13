//
//  SettingsFactory.swift
//  Day12-Forms
//
//  Created by Beatriz Cardozo on 13/8/24.
//

import Foundation

enum DisplayOrder : Int, CaseIterable {
    case alphabetical = 0
    case favourite = 1
    case purchased = 2
    
    
    init?(type: Int) {
        switch type {
        case 0:
            self = .alphabetical
        
        case 1:
            self = .favourite
            
        case 2:
            self = .purchased
            
        default:
            self = .alphabetical
        }
    }
    
    var text: String {
        switch self {
        case .alphabetical:
            return   "Alphabetic Order"
        
        case .favourite:
            return "Favorites"
            
        case .purchased:
            return "Purchased"

        }
    }
    
}


//User preferences
final class SettingsFactory {
    
    init() {
        UserDefaults.standard.register(defaults: [ //Important: dictionary
            "app.settings.displayOrder": 0,
            "app.settings.showPurchasedOnly": false,
            "app.settings.showFavoriteOnly": false,
            "app.settings.difficultyLevel": 4,
            "app.settings.minPrice": 0.0,
            "app.settings.maxPrice": 30.0,
        ])
    }
    
    var displayOrder: Int = UserDefaults.standard.integer(forKey: "app.settings.displayOrder") {
        didSet{
            UserDefaults.standard.set(displayOrder, forKey: "app.settings.displayOrder")
        }
    }
    
    var showPurchasedOnly: Bool = UserDefaults.standard.bool(forKey: "app.settings.showPurchasedOnly"){
        didSet{
            UserDefaults.standard.set(showPurchasedOnly, forKey: "app.settings.showPurchasedOnly")
        }
    }
    
    var showFavoriteOnly: Bool = UserDefaults.standard.bool(forKey: "app.settings.showFavoriteOnly"){
        didSet{
            UserDefaults.standard.set(showFavoriteOnly, forKey: "app.settings.showFavoriteOnly")
        }
    }
    
    var difficultyLevel: Int = UserDefaults.standard.integer(forKey: "app.settings.difficultyLevel") {
        didSet{
            UserDefaults.standard.set(difficultyLevel, forKey: "app.settings.difficultyLevel")
        }
    }
    
    var minPrice: Float = UserDefaults.standard.float(forKey: "app.settings.minPrice") {
        didSet{
            UserDefaults.standard.set(minPrice, forKey: "app.settings.minPrice")
        }
    }
    
    var maxPrice: Float = UserDefaults.standard.float(forKey: "app.settings.maxPrice") {
        didSet{
            UserDefaults.standard.set(maxPrice, forKey: "app.settings.maxPrice")
        }
    }
    
    
}
