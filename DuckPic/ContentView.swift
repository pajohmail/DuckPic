//
//  ContentView.swift
//  DuckPic
//
//  Created by Per-Arne Johansson on 2024-10-26.
//

import SwiftUI

struct ContentView: View {
    @State private var imageUrl: String = ""
    @State private var showImage: Bool = false

    var body: some View {
        VStack {
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



