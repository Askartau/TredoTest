//
//  DetailVIew.swift
//  Tredo
//
//  Created by Askar Serikkhanov on 4/6/21.
//

import Foundation
import UIKit
import SnapKit

class DetailVIew: UIView {
    var item: RecipeDetail? {
        didSet {
            imageView.kf.setImage(with: URL(string: item?.image ?? ""))
            minutesLabel.text = "Ready in: \(item?.readyInMinutes ?? 0) minutes"
            servingsLabel.text = "Servings: \(item?.servings ?? 0)"
            instructionsLabel.text = item?.instructions
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, minutesLabel, servingsLabel, instructionsLabel])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = 15
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var minutesLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        return view
    }()
    
    lazy var servingsLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        return view
    }()
    
    lazy var instructionsLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setUp()
    }
    
    func setUp() {
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(15)
            $0.top.bottom.equalToSuperview()
        })
        
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints({
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
