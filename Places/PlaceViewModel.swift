//
//  PlaceViewModel.swift
//  Places
//
//  Created by Monserrath Valenzuela on 18/08/25.
//

/*
 CLEAN CODE PRINCIPLES IMPLEMENTED:
 
1. SINGLE RESPONSIBILITY - Each function has one clear purpose
2. MEANINGFUL NAMES - Clear, descriptive variable and function names
3. SMALL FUNCTIONS - Functions are focused and concise
4. ERROR HANDLING - Robust network error management
5. SEPARATION OF CONCERNS - ViewModel handles data logic, not UI
6. CONSISTENT FORMATTING - Clean, readable code structure
 
*/

import Foundation

@Observable
@MainActor
class PlaceViewModel {
    
    // MARK: - Published Properties
    var arrPlaces = [Place]()
    var isLoading = false
    var errorMessage = ""
    
    // MARK: - Initialization
    init(){
        // Load data when ViewModel is created
        Task {
            await loadAPI()
        }
    }
    
    // MARK: - API Methods
    
    /// Loads places data from the API endpoint
    /// Handles loading states and error conditions
    /// SINGLE RESPONSIBILITY: Only handles API data fetching
    func loadAPI() async {
        // Set loading state - USER FEEDBACK
        isLoading = true
        errorMessage = ""
        
        do {
            // 1. URL Validation - MEANINGFUL ERROR MESSAGES
            guard let url = URL(string: "http://10.14.255.55:3000/places") else {
                await handleError("Invalid API URL")
                return
            }
            
            // 2. Create URL Request
            let urlRequest = URLRequest(url: url)
            
            // 3. Perform Network Call - ROBUST ERROR HANDLING
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            // 4. Validate HTTP Response
            guard let httpResponse = response as? HTTPURLResponse else {
                await handleError("Invalid server response")
                return
            }
            
            // 5. Check Status Code - SPECIFIC ERROR HANDLING
            guard httpResponse.statusCode == 200 else {
                await handleHTTPError(statusCode: httpResponse.statusCode)
                return
            }
            
            // 6. Decode JSON Data
            let results = try JSONDecoder().decode([Place].self, from: data)
            
            // 7. Update UI on Main Thread - SUCCESS STATE
            await updatePlaces(results)
            
        } catch {
            // ROBUST ERROR HANDLING for network/decoding errors
            await handleNetworkError(error)
        }
    }
    
    // MARK: - Error Handling Methods
    // SMALL FUNCTIONS with single responsibility
    
    /// Handles general errors and updates UI state
    private func handleError(_ message: String) async {
        errorMessage = message
        isLoading = false
    }
    
    /// Handles HTTP status code errors with specific messages
    private func handleHTTPError(statusCode: Int) async {
        let message: String
        
        switch statusCode {
        case 404:
            message = "API endpoint not found"
        case 500...599:
            message = "Server error. Please try again later."
        default:
            message = "Request failed with code \(statusCode)"
        }
        
        await handleError(message)
    }
    
    /// Handles network and decoding errors
    private func handleNetworkError(_ error: Error) async {
        let message: String
        
        // Check for common network issues - USER FRIENDLY MESSAGES
        if error.localizedDescription.contains("offline") ||
           error.localizedDescription.contains("network") ||
           error.localizedDescription.contains("Internet connection") {
            message = "No connection. Please try again."
        } else if error is DecodingError {
            message = "Data format error. Please try again."
        } else {
            message = "Failed to load data. Please try again."
        }
        
        await handleError(message)
    }
    
    /// Updates places array and clears loading/error states
    private func updatePlaces(_ places: [Place]) async {
        self.arrPlaces = places
        self.errorMessage = ""
        self.isLoading = false
    }
    
    // MARK: - Public Methods
    
    /// Manually reload data - for retry functionality
    /// MEANINGFUL NAME and single responsibility
    func reloadData() {
        Task {
            await loadAPI()
        }
    }
}
