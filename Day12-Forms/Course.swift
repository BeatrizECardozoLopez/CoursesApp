//
//  Course.swift
//  Day9-Lists
//
//  Created by Beatriz Cardozo on 10/8/24.
//

import Foundation

struct Course: Identifiable{ //Para el protocolo Identifier, ahora podemos iniciar la lista sin especificar cual parametro identificador
    
    var id = UUID() //Unsigned unique identifier, nos asegura que cada curso tengo su identificador unico. Compuesto por un numero de 128 bits por lo que la probabilidad de que algun identificador sea igual a otro es casi 0.
    var name : String
    var image : String
    var author: String
    var difficulty: Int
    var description : String
    
    
    
    
}

