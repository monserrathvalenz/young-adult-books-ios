//
//  ContentView.swift
//  Places
//
//  Created by Monserrath Valenzuela on 18/08/25.

/*
 PRINCIPLES SUCCESSFULLY IMPLEMENTED:
 
1. MEANINGFUL NAMES
2. SMALL FUNCTIONS/VIEWS
3. SINGLE RESPONSIBILITY PRINCIPLE
4. SEPARATION OF CONCERNS
5. CONSISTENT FORMATTING
6. APPROPRIATE COMMENTS
7. ROBUST ERROR HANDLING
8. USER FEEDBACK WITH LOADING STATES
 
*/

import SwiftUI

struct ContentView: View {
    @State private var placeViewModel = PlaceViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing:0) {
                
                // HEADER SECTION - Always visible
                HStack{
                    Spacer()// Al ponerlo antes de lo anterior hacemos que lo que este dentro del stack se recorra al lado derecho
                    Image(systemName:"ellipsis.circle.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.primary,.secondary.opacity(0.3))
                    //Ponerlo como .primary y .secundary hace que se adapte al modo oscuro, si pusieramos colores fijos estos no se adaptarian.
                }
                .padding(.horizontal)
                
                HStack{
                    Text("Young Adult")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontDesign(.serif)
                    Spacer()
                }
                .padding(.horizontal)
                .padding (.bottom, 3.5)
                Divider()
                    .padding(.horizontal)
                
                // CONTENT SECTION - Changes based on state
                Group {
                    // LOADING STATE - Show progress view while fetching data
                    if placeViewModel.isLoading {
                        VStack {
                            Spacer()
                            ProgressView("Loading places...")
                                .padding()
                            Spacer()
                        }
                    }
                    // ERROR STATE - Show error message and retry button
                    else if !placeViewModel.errorMessage.isEmpty {
                        VStack {
                            Spacer()
                            
                            Image(systemName: "exclamationmark.triangle")
                                .font(.system(size: 40))
                                .foregroundColor(.primary)
                                .padding(.bottom, 8)
                            
                            Text(placeViewModel.errorMessage)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            // RETRY FUNCTIONALITY - Single responsibility for error recovery
                            Button("Try Again") {
                                Task {
                                    await placeViewModel.loadAPI()  // ✅ CORRECTED: using instance method
                                }
                            }
                            .buttonStyle(.bordered)
                            
                            Spacer()
                        }
                       
                    }
                    // SUCCESS STATE - Show the list of places
                    else {
                        List {
                            ForEach(placeViewModel.arrPlaces) { item in
                                NavigationLink {
                                    PlaceDetailView(place: item)
                                } label: {
                                    PlaceRowView(place:item)
                                }
                            }
                        }
                        .listStyle(PlainListStyle()) //Elimina el fondo por defecto de List
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
