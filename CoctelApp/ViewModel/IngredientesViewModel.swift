//
//  IngredientesViewModel.swift
//  CoctelApp
//
//  Created by Jose David Bustos H on 12-08-24.
//

import Foundation
import Combine

class IngredientesViewModel: ObservableObject {
    @Published var ingredientes: [Ingredients] = []
    private let networkServices = NetworkService()
    var reloadLista: (() -> Void)?
    var arrayOfLista: [Ingredients] = [] {
        didSet {
            reloadLista?()
        }
    }
    
    init() {
        fetchIngredientes(letter: nil)
    }
    
    func fetchIngredientes(letter: String?) {
        networkServices.fetchIngredientes(letter: letter ?? "") { [weak self] response in
            guard let self = self, let response = response else { return }
            DispatchQueue.main.async {
                self.ingredientes = response
                self.arrayOfLista = self.ingredientes
            }
        }
    }
}

