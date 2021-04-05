//
//  MainCell.swift
//  Tredo
//
//  Created by Askar Serikkhanov on 4/5/21.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class MainCell: UICollectionViewCell {
    static let reuseIdentifier = "MainCell"
    
    var item: Recipe? {
        didSet {
            mainImageView.kf.setImage(with: APIManager.getImageUrl(name: item?.image))
            titleLabel.text = item?.title
        }
    }
    
    lazy var mainImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .medium)
        view.numberOfLines = 0
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainImageView.snp.makeConstraints({
            $0.height.equalTo(mainImageView.frame.width)
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    func setUp() {
        addSubViews([mainImageView, titleLabel])
        
        mainImageView.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(10)
            $0.top.equalToSuperview().offset(10)
        })
        
        titleLabel.snp.makeConstraints({
            $0.top.equalTo(mainImageView.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview().inset(10)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
