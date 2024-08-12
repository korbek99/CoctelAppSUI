//
//  DetailCoctelView.swift
//  CoctelApp
//
//  Created by Jose David Bustos H on 11-08-24.
//
import SwiftUI

struct DetailCoctelView: View {
    //@ObservedObject var viewModels: IngredientesViewModel
    let drink: Drinks

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let imageUrl = URL(string: drink.strDrinkThumb) {
                    LoadableImageView(url: imageUrl)
                        .frame(height: 300)
                        .cornerRadius(8)
                        .padding(.bottom, 16)
                }

                Text(drink.strDrink)
                    .font(.largeTitle)
                    .padding(.bottom, 8)

                Text(drink.strCategory)
                    .font(.headline)
                    .padding(.bottom, 8)

                Text("Alcoholic: \(drink.strAlcoholic)")
                    .font(.subheadline)
                    .padding(.bottom, 8)

                Text("Glass: \(drink.strGlass)")
                    .font(.subheadline)
                    .padding(.bottom, 8)

                Text("Instructions:")
                    .font(.headline)
                    .padding(.top, 16)

                Text(drink.strInstructions)
                    .font(.body)
                    .padding(.top, 4)
            }
            .padding()
        }
        .navigationTitle(drink.strDrink)
//        .onAppear {
//            viewModels.fetchIngredientes(letter: drink.strDrink)
//        }
    }
}
