//
//  ContentView.swift
//  FlickrSearchApp
//
//  Created by Mukesh Nethi on 11/19/24.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [FlickrItem] = [] // Stores the fetched items
    @State private var searchText: String = "porcupine" // Default search term

    var body: some View {
        VStack {
            // Search Bar
            TextField("Enter tags to search", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onSubmit {
                    fetchImages() // Fetch images when the user submits the search
                }

            // List of Image Titles (For Testing)
            if items.isEmpty {
                Text("No images loaded. Try searching for something!")
                    .padding()
            } else {
                List(items) { item in
                    Text(item.title)
                }
            }
        }
        .onAppear {
            fetchImages() // Fetch images when the view appears
        }
    }

    // Function to fetch images
    private func fetchImages() {
        FlickrService().fetchImages(for: searchText) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedItems):
                    items = fetchedItems // Update the state with fetched items
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
