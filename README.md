# Young Adult Books - iOS App with Custom API
### What the app does
This project consists of an iOS SwiftUI application paired with a custom Flask API that displays a curated collection of popular Young Adult books. Users can browse through YA literature, view detailed information about each book including descriptions, author information, ratings, and review counts.

### Key Features:

- List View: Browse all YA books with titles and basic info
- Detail View: Tap any book to see full descriptions, author information, ratings, and review counts
- Robust Error Handling: Graceful handling of network failures with user-friendly messages
- Loading States: Visual feedback during data fetching
- Clean Design: Modern SwiftUI interface with dark mode support
- Custom API: Self-hosted Flask server providing book data

### Custom Flask API Endpoint:
http://10.14.255.55:3000/places

Returns JSON array with book data including:

- Book name and author
- Book description
- Ratings and review counts
- Image identifiers
  

## How to run the project
### Part 1:
 1. Navigate to API directory: bashcd places-api-student01
 2. Run the API server: bashpython3 app.py
 3. Verify API is running: curl http://localhost:3000/places

### Part 2: Running the iOS App
1. Ensure API server is running (from Part 1)
2. Open iOS project: bashopen Places.xcodeproj
3. Verify API URL in PlaceViewModel.swift: swiftguard let url = URL(string: "http://10.14.255.55:3000/places")

## Troubleshooting:
- "No connection" error: Verify API server is running with python3 app.py
- Connection refused: Check that both devices are on the same network
- Port issues: Use lsof -i :3000 to check if port is available
