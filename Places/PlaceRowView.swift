//
//  PlaceRowView.swift
//  Places
//
//  Created by Monserrath Valenzuela on 18/08/25.
//
import SwiftUI

struct PlaceRowView: View {

    let place : Place

    var body: some View {
        
        HStack{
            
            Image(place.imageName[0])
                .resizable()
                .scaledToFit()
                .frame(width:100, height: 100)
            
            VStack(alignment: .leading) {
                Text(place.name)
                HStack{
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.gray)
                        
                    Text("\(place.score, specifier: "%.1f")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.leading, -1)
                    
                    Text("(\(place.nopinions))")
                        .foregroundStyle(.tertiary)
                        .font(.caption)
                        .padding(.leading, -1)
                        
                }
            }
        }
        
        .padding(.leading, -16) //Utilizamos este padding para arreglar el padding extra que salia en los elementos de las listas

    }
}
#Preview {

    PlaceRowView(place: Place(id: 1, name: "ChichenItza", title: "Chichen Itza", description: "Description", autor: "", imageName: ["TOG"], score: 4, nopinions: "330"))
}
