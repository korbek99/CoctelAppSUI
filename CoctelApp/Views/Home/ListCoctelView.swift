//
//  ListCoctelView.swift
//  CoctelApp
//
//  Created by Jose David Bustos H on 11-08-24.
//
import SwiftUI
import Combine

struct ListCoctelView: View {
    @ObservedObject var viewModel: CoctelViewModel
    @State private var searchText = ""
    @State private var selectedLetter: String?

    var filteredDrinks: [Drinks] {
        var drinks = viewModel.arrayOfList

        if !searchText.isEmpty {
            drinks = drinks.filter { $0.strDrink.lowercased().contains(searchText.lowercased()) }
        }

        return drinks
    }

    var alphabet: [String] {
        return "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { String($0) }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Buscar coctel", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List(filteredDrinks, id: \.idDrink) { drink in
                    NavigationLink(destination: DetailCoctelView(drink: drink)) {
                        HStack(alignment: .top) {
                            if let imageUrl = URL(string: drink.strDrinkThumb) {
                                LoadableImageView(url: imageUrl)
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(8)
                            }

                            VStack(alignment: .leading) {
                                Text(drink.strDrink)
                                    .font(.headline)
                                Text(drink.strCategory)
                                    .font(.subheadline)
                                Text(drink.strAlcoholic)
                                    .font(.subheadline)
                                Text(drink.strGlass)
                                    .font(.subheadline)
                            }
                            .padding(.leading, 8)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(alphabet, id: \.self) { letter in
                            Button(action: {
                                self.selectedLetter = letter
                                viewModel.fetchIndicadores(letter: letter)
                            }) {
                                Text(letter)
                                    .font(.headline)
                                    .padding()
                                    .background(self.selectedLetter == letter ? Color.blue : Color.gray)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                            .padding(2)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Cocteles")
            .onAppear {
                viewModel.fetchIndicadores(letter: nil) 
            }
        }
    }
}

struct LoadableImageView: View {
    let url: URL
    @State private var loadedImage: UIImage? = nil

    var body: some View {
        Group {
            if let image = loadedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .onAppear(perform: loadImage)
            }
        }
    }

    private func loadImage() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.loadedImage = uiImage
                }
            }
        }.resume()
    }
}

struct ListCoctelView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CoctelViewModel()
        ListCoctelView(viewModel: viewModel)
    }
}
