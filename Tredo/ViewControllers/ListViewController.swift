//
//  ViewController.swift
//  Tredo
//
//  Created by Askar Serikkhanov on 4/5/21.
//

import UIKit

class ListViewController: UIViewController {
    var items: [Recipe]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy var viewModel: ListViewModel = {
        let view = ListViewModel()
        view.updateData = updateData(_:)
        view.appendData = appendData(_:)
        return view
    }()
    
    lazy var searchController: UISearchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchResultsUpdater = self
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        view.delaysContentTouches = false
        view.register(MainCell.self, forCellWithReuseIdentifier: MainCell.reuseIdentifier)
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        view = collectionView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Recipes"
        navigationItem.searchController = searchController
    }
    
    func updateData(_ items: [Recipe]) {
        self.items = items
    }
    
    func appendData(_ items: [Recipe]) {
        guard var selfItems = self.items else { return }
        selfItems.append(contentsOf: items)
        print(selfItems)
        self.items = selfItems
    }
}

extension ListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text != "" else { return }
        viewModel.getData(query: text)
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.reuseIdentifier, for: indexPath) as! MainCell
        cell.item = items?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let count = items?.count, indexPath.item == count - 1 else { return }
        viewModel.getNextPage()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = items?[indexPath.item].id else { return }
        navigationController?.pushViewController(DetailViewController(id: id), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
