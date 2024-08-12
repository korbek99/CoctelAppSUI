//
//  CoctelViewModel.swift
//  CoctelApp
//
//  Created by Jose David Bustos H on 11-08-24.
//

import Foundation
import Combine

class CoctelViewModel: ObservableObject {
    @Published var indicadores: [Drinks] = []
    private let networkService = NetworkService()
    var reloadList: (() -> Void)?
    var arrayOfList: [Drinks] = [] {
        didSet {
            reloadList?()
        }
    }
    
    init() {
        fetchIndicadores(letter: nil)
    }
    
    func fetchIndicadores(letter: String?) {
        networkService.fetchIndicadores(letter: letter ?? "") { [weak self] response in
            guard let self = self, let response = response else { return }
            DispatchQueue.main.async {
                self.indicadores = response
                self.arrayOfList = self.indicadores
            }
        }
    }
}

