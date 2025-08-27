//
//  PlaceDetailView.swift
//  Places
//
//  Created by Monserrath Valenzuela on 18/08/25.
//

import SwiftUI

struct PlaceDetailView: View {
    let place : Place
    
    var body: some View {
        
        VStack {
            VStack {
                Image(place.imageName[0])
                    .resizable()
                    .scaledToFit( )
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.red)
                    .padding(.top, 20)
                
                Rectangle()
                    .fill(.tertiary)
                    .frame(height: 2)
                    .padding([.top, .bottom], 8)
                    .padding(.horizontal, 140)
                
                Text(place.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .fontDesign(.serif)
                    .padding(.top, 0)
                    .padding(.bottom, 1)
                
                HStack{
                    Text(place.autor)
                        .font(.caption)
                        .padding(.top, 0)
                        
                    
                    Image(systemName: "chevron.forward")
                        .resizable()
                        .frame(width: 6, height: 8)
                        .opacity(0.5)
                }
                .padding(.bottom, 9)
                    
                
                HStack{
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    
                    Text("\(place.score,  specifier: "%.1f")")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .padding(.leading, -1)
                    
                    Text("(\(place.nopinions))")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                        .padding(.leading, -1)
                }
                .padding(.bottom, 15)
            }
            
            
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: [
                        .primary.opacity(0.1),
                        .secondary.opacity(0.2),
                        .clear
                    ],
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
            
            VStack(alignment: .leading){
                Text("Synopsis")
                    .font(.headline)
                    .fontWeight(.bold)
                    .fontDesign(.serif)
                
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)
                    
                
                
                Text(place.description)
                    .font(.caption)
                    .padding(.top, 2)
                    .padding(.horizontal, 20)
                    
            }
            
            Spacer()
            
        }
        
        //Segundo background
    }
    
}

#Preview {
    PlaceDetailView(place: Place(id: 1, name: "Trone of Glass", title: "ChichenItza", description: "Chichen Itza is a famous ancient Mayan city in Mexico, known for its impressive pyramid Kukulkan. It was a major center of politics, religion, and astronomy, and is now one of the New Seven Wonders of the World.", autor: "Sarah J. Maas", imageName:["TOG"], score: 4, nopinions: "330"))
}
