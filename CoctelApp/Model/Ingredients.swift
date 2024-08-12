//
//  Ingredient.swift
//  CoctelApp
//
//  Created by Jose David Bustos H on 12-08-24.
//

import Foundation

struct Ingredients: Codable {
    let idIngredient: String
    let strIngredient: String
    let strDescription: String
    let strType: String
    let strAlcohol: String
    let strABV: String
}

struct IngredientsResponse: Codable {
    let ingredients: [Ingredients]
}
