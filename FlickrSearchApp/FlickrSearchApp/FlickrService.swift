//
//  FlickrService.swift
//  FlickrSearchApp
//
//  Created by Mukesh Nethi on 11/19/24.
//
import Foundation

class FlickrService {
    func fetchImages(for tags: String, completion: @escaping (Result<[FlickrItem], Error>) -> Void) {
        // Construct the API URL with the user-provided tags
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(tags)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        // Perform the network request
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle potential errors
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            // Decode the JSON response into our data model
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(FlickrAPIResponse.self, from: data)
                completion(.success(apiResponse.items))
            } catch {
                completion(.failure(error))
            }
        }.resume() // Start the network request
    }
}

