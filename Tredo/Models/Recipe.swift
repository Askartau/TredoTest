//
//  Recipe.swift
//  Tredo
//
//  Created by Askar Serikkhanov on 4/6/21.
//

import Foundation

class SearchResponse: Codable {
    var results: [Recipe]?
    var offset: Int?
    var totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case results, offset, totalResults
    }
}

class Recipe: Codable {
    var id: Int?
    var title: String?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, image
    }
}

class RecipeDetail: Codable {
    var id: Int?
    var title: String?
    var image: String?
    var readyInMinutes: Int?
    var servings: Int?
    var instructions: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, readyInMinutes, servings, instructions
    }
}
