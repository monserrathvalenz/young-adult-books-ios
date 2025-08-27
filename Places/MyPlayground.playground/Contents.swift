import UIKit

var greeting = "Hello, playground"

import SwiftUI
import Foundation

var arrPlaces = [Place]()
//Identifiable: permite generar lo del ID para hacer posible el traspaso de las fotos
//Decodable: permite tomar la info del JSON
struct Place : Identifiable, Decodable {
    var id : Int
    var name : String
    var title: String
    var description: String
    var autor : String
    var imageName : [String]
    var score: Double
    var nopinions: String
    
    enum CodingKeys: String, CodingKey {
    case name
    case title
    case description
    case autor
    case imageName
    case score
    case nopinions
        
    }
}

func loadPlaces() async throws -> [Place] {
    let url = URL(string: "http://10.14.255.55:3000/places")
    let(data, _) = try await URLSession.shared.data(from: url!)
    let places = try JSONDecoder().decode([Place].self, from: data)
    return places
}

Task {
    arrPlaces = try await loadPlaces()
    arrPlaces.forEach { item in
    print(item.name)
    }
}
