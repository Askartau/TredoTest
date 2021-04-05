//
//  ActivityIndicator.swift
//  Tredo
//
//  Created by Askar Serikkhanov on 4/6/21.
//

import Foundation
import UIKit

class ActivityIndicator: UIActivityIndicatorView {
    static var navigationController: UINavigationController!
    
    func stop() {
        stopAnimating()
        removeFromSuperview()
    }
    
    static func start() -> ActivityIndicator {
        let activityIndicator = ActivityIndicator(style: .large)
        navigationController.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
        activityIndicator.startAnimating()
        return activityIndicator
    }
}
