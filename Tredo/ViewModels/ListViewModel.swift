//
//  ListViewModel.swift
//  Tredo
//
//  Created by Askar Serikkhanov on 4/6/21.
//

import Foundation
import UIKit

class ListViewModel {
    var updateData: ((_ items: [Recipe])->())?
    var appendData: ((_ items: [Recipe])->())?
    
    var response: SearchResponse? {
        didSet {
            guard let items = response?.results, let offset = response?.offset, let totalResults = response?.totalResults else { return }
            updateData?(items)
            self.offset = offset
            self.totalResults = totalResults
        }
    }
    
    var appendResponse: SearchResponse? {
        didSet {
            guard let items = response?.results, let offset = response?.offset, let totalResults = response?.totalResults else { return }
            appendData?(items)
            self.offset = offset
            self.totalResults = totalResults
        }
    }
    
    var offset = 0
    var totalResults: Int?
    var query: String?
    
    func getData(query: String) {
        self.query = query
        offset = 0
        totalResults = nil
        let activityIndicator = ActivityIndicator.start()
        APIManager.searchItems(query: query) { error, object in
            self.response = object
            activityIndicator.stop()
        }
    }
    
    func getNextPage() {
        guard offset < totalResults ?? 0, let query = query else { return }
        offset += 10
        let activityIndicator = ActivityIndicator.start()
        APIManager.searchItems(query: query, offset: offset) { error, object in
            self.appendResponse = object
            activityIndicator.stop()
        }
    }
}
