//
//  Place.swift
//  Places
//
//  Created by Monserrath Valenzuela on 18/08/25.
//

import Foundation

struct Place : Identifiable, Decodable {
    var id : Int
    var name: String
    var title: String
    var description: String
    var autor: String
    var imageName: [String]
    var score: Double
    var nopinions: String
    
    //
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case title
        case description
        case autor
        case imageName
        case score
        case nopinions
    }
    
}
