//
//  TitleCollectionViewCell.swift
//  HW_CollectionView_Trello
//
//  Created by Давид on 09/11/2019.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TitleCell"
    
    let titleText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5.0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleText)
        titleText.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleText.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleText.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleText.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        titleText.text = ""
    }
}
