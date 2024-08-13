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
    @State private var minPrice = 0.0
    @State private var maxPrice = 30.0
    
    var settings: SettingsFactory
    
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
            
            //Save Chages Button
            Button{
                //TODO: save to SettingsFactory
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
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(20)
                .padding(.horizontal, 30)
            }
        }
        
    }
}

#Preview {
    SettingsView(settings: SettingsFactory())
}
