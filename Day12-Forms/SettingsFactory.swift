//
//  SettingsFactory.swift
//  Day12-Forms
//
//  Created by Beatriz Cardozo on 13/8/24.
//

import Foundation
import Combine //Observable objects

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
    
    //Sort function: devuelve un clousure de orden 
    func sortPredicate() -> ((Course, Course) -> Bool) {
        switch self {
        case .alphabetical:
            return {$0.name < $1.name}
        
        case .favourite:
            return {$0.isFavorite && !$1.isFavorite}
            
        case .purchased:
            return {$0.isPurchased && !$1.isPurchased}
        }
    }
}


//User preferences
final class SettingsFactory: ObservableObject { //Observable Object
    
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
    
    @Published var displayOrder: Int = UserDefaults.standard.integer(forKey: "app.settings.displayOrder") { //@Published to know when a variable changes (Framework: Combine)
        didSet{
            UserDefaults.standard.set(displayOrder, forKey: "app.settings.displayOrder")
        }
    }
    
    @Published var showPurchasedOnly: Bool = UserDefaults.standard.bool(forKey: "app.settings.showPurchasedOnly"){
        didSet{
            UserDefaults.standard.set(showPurchasedOnly, forKey: "app.settings.showPurchasedOnly")
        }
    }
    
    @Published var showFavoriteOnly: Bool = UserDefaults.standard.bool(forKey: "app.settings.showFavoriteOnly"){
        didSet{
            UserDefaults.standard.set(showFavoriteOnly, forKey: "app.settings.showFavoriteOnly")
        }
    }
    
    @Published var difficultyLevel: Int = UserDefaults.standard.integer(forKey: "app.settings.difficultyLevel") {
        didSet{
            UserDefaults.standard.set(difficultyLevel, forKey: "app.settings.difficultyLevel")
        }
    }
    
    @Published var minPrice: Float = UserDefaults.standard.float(forKey: "app.settings.minPrice") {
        didSet{
            UserDefaults.standard.set(minPrice, forKey: "app.settings.minPrice")
        }
    }
    
    @Published var maxPrice: Float = UserDefaults.standard.float(forKey: "app.settings.maxPrice") {
        didSet{
            UserDefaults.standard.set(maxPrice, forKey: "app.settings.maxPrice")
        }
    }
    
    
}
