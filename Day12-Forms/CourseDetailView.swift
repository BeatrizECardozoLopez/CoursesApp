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
            
            Text(("Creado por " + course.author).uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundStyle(.secondary)
                .padding(.horizontal, 10)
                .padding(.bottom, 2)
            
            HStack  (spacing: 2){
                ForEach(1...(course.difficulty), id: \.self) { _ in
                    Image(systemName: "star")
                        .font(.caption)
                        .foregroundStyle(.purple)
                }
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
    CourseDetailView(course: Course(
        name: "Curso de Swift 5 desde cero",
        image: "swift5",
        author: "Juan Gabriel Gomillas",
        difficulty: 3,
        description: "Un curso que te ayudará a programar como un  profesional!"))
}
