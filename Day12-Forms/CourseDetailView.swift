//
//  CourseDetailView.swift
//  Day9-Lists
//
//  Created by Beatriz Cardozo on 12/8/24.
//

import SwiftUI

struct CourseDetailView: View {
    
    @Environment(\.dismiss) var dismiss //VARIABLE DE ENTORNO: SOLO EXISTE DESDE IOS 15 EN ADELANTE
//    @Environment(\.presentationMode) var presentationMode VERSION VIEJA: antes de iOS 15
    var course: Course
    
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 10){
            
            Image(course.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10.0)
            
            Text(course.name)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.black)
                .padding(.horizontal, 10)
                .padding(.bottom, 2)
            
            Text(("By " + course.author).uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundStyle(.secondary)
                .padding(.horizontal, 10)
                .padding(.bottom, 2)
            
            HStack (spacing: 2){
                Text("Difficulty: ")
                    .font(.caption)
                    .bold()
                
                    .foregroundStyle(.purple)
                Image(systemName: "cellularbars", variableValue: Double(course.difficulty)/4)
                    .font(.subheadline)
                    .foregroundColor(.purple)
            } .padding(.horizontal, 10)
            
            Text(course.description)
                .font(.system(.subheadline))
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            
            Spacer() //que lo empuja todo hacia arriba

        }
        .padding()
        
        //Esconder el boton de regreso dado por defecto PARA PODER CONSTRUIR NUESTRO PROPIO BOTON
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                Button() {
                    // presentationMode.wrappedValue.dismiss() VERSION VIEJA: antes de iOS 15
                    dismiss() //viene de la variable de entorno
                } label: {
                    Text("\(Image(systemName: "arrow.left.square")) \(course.name)")
                        .foregroundStyle(.purple)
                }
                
            }
        }
    }
    
    
}

#Preview {
    CourseDetailView(course: Course(name: "Data Analysis with R", image: "data_analysis_r.jpg", author: "Mia Miller", difficulty: 3, description: "Analyzing data using the R language", price: 11.99))
}
