//
//  APIManager.swift
//  Tredo
//
//  Created by Askar Serikkhanov on 4/6/21.
//

import Foundation
import Alamofire

class APIManager {
    private static let token = "cb444f28e48441aab56903eb674969bb"
    private static let baseUrl = URL(string: "https://api.spoonacular.com/")!
    private static let headers: HTTPHeaders = [:]
    
    static func searchItems(query: String = "", offset: Int = 0, completion: @escaping(_ error:String?,_ module: SearchResponse?)->()) {
        let parameters: Parameters = [
            "query": query,
            "apiKey": token,
            "offset": offset
        ]
        AF.request(APIManager.baseUrl.appendingPathComponent("recipes/search"), method: .get, parameters: parameters, encoding: URLEncoding(), headers: APIManager.headers).responseData() { response in
            guard let responseData = response.data else { return }
            do {
                let apiResponse = try JSONDecoder().decode(SearchResponse.self, from: responseData)
                completion(nil, apiResponse)
            }
            catch {
                completion("Error", nil)
            }
        }
    }
    
    static func getItemDetail(id: Int, completion: @escaping(_ error:String?,_ module: RecipeDetail?)->()) {
        let parameters: Parameters = [
            "apiKey": token
        ]
        AF.request(APIManager.baseUrl.appendingPathComponent("recipes/\(id)/information"), method: .get, parameters: parameters, encoding: URLEncoding(), headers: APIManager.headers).responseData() { response in
            guard let responseData = response.data else { return }
            do {
                let apiResponse = try JSONDecoder().decode(RecipeDetail.self, from: responseData)
                completion(nil, apiResponse)
            }
            catch {
                completion("Error", nil)
            }
        }
    }
    
    static func getImageUrl(name: String?) -> URL? {
        guard let name = name else { return nil }
        return URL(string: "https://spoonacular.com/recipeImages/\(name)")
    }
}
