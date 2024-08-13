//
//  SettingsView.swift
//  Day12-Forms
//
//  Created by Beatriz Cardozo on 13/8/24.
//

import SwiftUI

struct SettingsView: View {
    
    
    private var availableOrders = [
        "Alphabetic Order",
        "Favorites",
        "Purchased"
    ]
    
    @State private var selectedOrder = 0
    
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
                
                Section(header: Text("Filter courses")){
                    Text("Filters")
                }
            }
        }
        
    }
}

#Preview {
    SettingsView()
}
