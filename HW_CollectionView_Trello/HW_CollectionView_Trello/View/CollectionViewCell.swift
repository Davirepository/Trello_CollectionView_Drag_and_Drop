//
//  CollectionViewCell.swift
//  HW_CollectionView_Trello
//
//  Created by Давид on 07/11/2019.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "Cell"
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = UIFont.boldSystemFont(ofSize: 14)
        textView.textAlignment = .left
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        return textView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.text = "Save it"
        label.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5.0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addSubview(titleTextView)
        addSubview(label)
        titleTextView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        titleTextView.bottomAnchor.constraint(equalTo:label.topAnchor, constant: -5).isActive = true
        
        label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 5.0
        
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: -2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleTextView.text = ""
    }
}
