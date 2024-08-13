//
//  SettingsView.swift
//  Day12-Forms
//
//  Created by Beatriz Cardozo on 13/8/24.
//

import SwiftUI

struct SettingsView: View {
    
    //Variable de Entorno
    @Environment(\.dismiss) var dismiss
    
    
    private var availableOrders = [
        "Alphabetic Order",
        "Favorites",
        "Purchased"
    ]
    
    @State private var selectedOrder = 0
    @State private var showPurchased = false
    @State private var showFavorite = false
    @State private var difficultyLevel = 4 //higher difficulty available
    @State private var minPrice = 0.0
    @State private var maxPrice = 30.0
    
    var body: some View {
        
        NavigationStack {
            Form {
                //PickerView
                Section(header: Text("Courses Order")){
                    Picker(selection: $selectedOrder, label: Text("Order")){
                        ForEach(0..<availableOrders.count, id: \.self) {
                            Text(self.availableOrders[$0])
                        }
                    }
                }
                
                //Interruptor (Toggle)
                Section(header: Text("Filter courses")){
                    
                    //Filter
                    Toggle(isOn: $showPurchased){
                        Text("Purchased Courses Only")
                    }
                    
                    //Filter
                    Toggle(isOn: $showFavorite){
                        Text("Favorite Courses Only")
                    }
                    
                    
                    //Stepper for difficulty
                    Stepper {
                        self.difficultyLevel += 1
                        if self.difficultyLevel > 4 {
                            self.difficultyLevel = 4
                        }
                    } onDecrement: {
                        self.difficultyLevel -= 1
                        if self.difficultyLevel < 1 {
                            self.difficultyLevel = 1
                        }
                    } label: {
                        Text("Level \(Image(systemName: "cellularbars", variableValue: Double(difficultyLevel)/4)) or less")
                            .foregroundStyle(.purple)
                    }
                    
                    //Slider
                    DisclosureGroup("Price Range") {
                        Text("Courses between \(Int(minPrice))$ - \(Int(maxPrice))$")
                            .foregroundStyle(.purple)
                            .bold()
                        
                        //Minimum Price
                        Slider(value: $minPrice, in: 0...(maxPrice - 1), step: 1) {
                            //Nothing here
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("\(Int(maxPrice-1))")
                        }
                        
                        //Maximun Price
                        Slider(value: $maxPrice, in: minPrice...30, step: 1) {
                            //Nothing here
                        } minimumValueLabel: {
                            Text("\(Int(minPrice + 1))")
                        } maximumValueLabel: {
                            Text("30")
                        }
                    }
                }
            }
        }
        .overlay (
            HStack {
                Spacer()
                VStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                    .padding(.trailing, 16)
                    Spacer()
                }
            }
        )
        
    }
}

#Preview {
    SettingsView()
}
