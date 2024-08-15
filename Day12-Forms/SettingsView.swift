//
//  SettingsView.swift
//  Day12-Forms
//
//  Created by Beatriz Cardozo on 13/8/24.
//

import SwiftUI

struct SettingsView: View {
    
    //Enviroment variable
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedOrder = DisplayOrder.alphabetical //default value from enum
    @State private var showPurchasedOnly = false
    @State private var showFavoriteOnly = false
    @State private var difficultyLevel = 4 //higher difficulty available
    @State private var minPrice: Float = 0.0
    @State private var maxPrice: Float = 30.0
    
    @EnvironmentObject var settings: SettingsFactory //Framework Combine
    
    var body: some View {
        
        NavigationStack {
            Form {
                //PickerView
                Section(header: Text("Courses Order")){
                    Picker(selection: $selectedOrder, label: Text("Order")){
                        ForEach(DisplayOrder.allCases, id: \.self) { order in
                            Text(order.text)
                        }
                    }
                }
                
                //Interruptor (Toggle)
                Section(header: Text("Filter courses")){
                    
                    //Filter
                    Toggle(isOn: $showPurchasedOnly){
                        Text("Purchased Courses Only")
                    }
                    
                    //Filter
                    Toggle(isOn: $showFavoriteOnly){
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
                        Slider(value: $minPrice, in: 0...30, step: 1) {
                            //Nothing here
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("30")
                        }
                        
                        //Maximun Price
                        Slider(value: $maxPrice, in: 0...30, step: 1) {
                            //Nothing here
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("30")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 15))
                            .padding(5)
                            .foregroundColor(.white)
                            .fontWeight(.black)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                }
            }
            
            //Reset Filters Button
            HStack {
                Button{
                    self.showFavoriteOnly = false
                    self.settings.showFavoriteOnly = false
                    
                    self.showPurchasedOnly = false
                    self.settings.showPurchasedOnly = false
                    
                    self.selectedOrder = DisplayOrder.alphabetical
                    self.settings.displayOrder = 0
                    
                    self.difficultyLevel = 4
                    self.settings.difficultyLevel = 4
                    
                    self.minPrice = 0
                    self.settings.minPrice = 0
                    
                    self.maxPrice = 30
                    self.settings.maxPrice = 30
                } label: {
                    Label(
                        title: {
                            Text("Reset Filters")
                                .fontWeight(.bold)
                                .font(.system(size: 15, design: .rounded))
                        },
                        icon: {}
                    )
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(20)
                    .padding(.horizontal, 10)
                }
               
                Button{
                    self.settings.showFavoriteOnly = self.showFavoriteOnly
                    self.settings.showPurchasedOnly = self.showPurchasedOnly
                    self.settings.displayOrder = self.selectedOrder.rawValue //rawValue to save just the id
                    self.settings.difficultyLevel = self.difficultyLevel
                    
                    //In case minPrice is bigger than maxPrice, we switch them
                    if(self.minPrice > self.maxPrice) {
                        let aux = self.minPrice
                        self.minPrice = self.maxPrice
                        self.maxPrice = aux
                    }
                    
                    self.settings.minPrice = self.minPrice
                    self.settings.maxPrice = self.maxPrice
                    
                    //Before quitting we save everything, all the user default settings
                    dismiss()
                } label: {
                    Label(
                        title: {
                            Text("Save changes")
                                .fontWeight(.bold)
                                .font(.system(size: 15, design: .rounded))
                        },
                        icon: {}
                    )
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(20)
                    .padding(.horizontal, 10)
                }
                
            }
        }
        .onAppear { //load user defaults
            self.showFavoriteOnly = self.settings.showFavoriteOnly
            self.showPurchasedOnly = self.settings.showPurchasedOnly
            self.selectedOrder = DisplayOrder(type: self.settings.displayOrder) ?? .alphabetical //convert from int to enum
            self.difficultyLevel = self.settings.difficultyLevel
            self.minPrice = self.settings.minPrice
            self.maxPrice = self.settings.maxPrice
            
            if(self.maxPrice < self.minPrice) {
                self.maxPrice = 30.0
                self.minPrice = 0.0
            }
        }
        
    }
}

#Preview {
    SettingsView().environmentObject(SettingsFactory()) //Framework: Combine
}
