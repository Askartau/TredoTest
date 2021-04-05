//
//  DetailViewModel.swift
//  Tredo
//
//  Created by Askar Serikkhanov on 4/6/21.
//

import Foundation

class DetailViewModel {
    var setData: ((_ item: RecipeDetail)->())?
    
    func getData(id: Int) {
        APIManager.getItemDetail(id: id) { error, response in
            guard let response = response else { return }
            self.setData?(response)
        }
    }
}
