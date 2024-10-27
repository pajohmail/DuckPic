//
//  ContentView.swift
//  DuckPic
//
//  Created by Per-Arne Johansson on 2024-10-26.
//
import SwiftUI

/// A SwiftUI view that displays a random duck image fetched from an API.
struct ContentView: View {
    /// The URL of the image to be displayed.
    @State private var imageUrl: String = ""
    /// A boolean state to control whether the image is shown or not.
    @State private var showImage: Bool = false

    var body: some View {
        ZStack {
            // Apply yellow background to the entire screen.
            Color.yellow.edgesIgnoringSafeArea(.all)

            VStack {
                // Header text with white color.
                Text("Duck pic")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()

                // Conditionally display the image if `showImage` is true and `imageUrl` is valid.
                if showImage, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                        } else if phase.error != nil {
                            Text("Error loading image")
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(height: 300)
                    .padding()
                }

                // Button to fetch and display a random duck image.
                Button(action: fetchRandomImage) {
                    Text("Show Random Duck")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }

    /// Fetches a random duck image URL from the "https://random-d.uk/api/random" API
    /// and updates the `imageUrl` and `showImage` state variables.
    func fetchRandomImage() {
        guard let url = URL(string: "https://random-d.uk/api/random") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []), let dict = json as? [String: Any], let url = dict["url"] as? String {
                DispatchQueue.main.async {
                    self.imageUrl = url
                    self.showImage = true
                }
            }
        }.resume()
    }
}


