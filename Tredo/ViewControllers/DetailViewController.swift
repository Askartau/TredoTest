//
//  DetailViewController.swift
//  Tredo
//
//  Created by Askar Serikkhanov on 4/6/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    lazy var mainView = DetailVIew()
    lazy var viewModel = DetailViewModel()
    
    var itemId: Int
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.setData = setData(_:)
        viewModel.getData(id: itemId)
    }
    
    func setData(_ item: RecipeDetail) {
        title = item.title
        mainView.item = item
    }
    
    required init (id: Int) {
        self.itemId = id
        
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
