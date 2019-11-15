//
//  DataSource.swift
//  HW_CollectionView_Trello
//
//  Created by Давид on 07/11/2019.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class DataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var data = Data()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath) as! TitleCollectionViewCell
            cell.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            cell.titleText.text = "\(data.sectionLabel[indexPath.section]) \n(add new)"
            return cell
        }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            let fromData = data.data[indexPath.section]
        cell.titleTextView.text = fromData[indexPath.item]
            return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.sectionLabel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}
