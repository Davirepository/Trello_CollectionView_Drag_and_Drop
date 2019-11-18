//
//  CustomLayout.swift
//  HW_CollectionView_Trello
//
//  Created by Давид on 07/11/2019.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

//public protocol LiquidLayoutDelegate {
//    func collectionView(collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath, width: CGFloat) -> CGFloat
//}

class CustomLayout: UICollectionViewLayout {
    
    private var cellHeight = 100.0
    private let cellWidth = Double(UIScreen.main.bounds.width - 60.0)
    let width = UIScreen.main.bounds.width
    private let cellPadding = 10.0
    private let cellPaddingX = 10.0
    private let cellPaddingY = 50.0
    private var contentSize = CGSize.zero
    
    private var cellAttribsDictionary = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    
    override var collectionViewContentSize: CGSize {
        return self.contentSize
    }
    
    override func prepare() {
        
        guard let collectionView = collectionView else { return }
        guard collectionView.numberOfSections > 0 else { return }
        cellAttribsDictionary.removeAll()
        collectionView.endEditing(true)
        
        var maxElementInSection = 0
        // Determine current content offsets.
        let yOffset = collectionView.contentOffset.y
        
        // Cycle through each section of the data source.
        for section in 0..<collectionView.numberOfSections {
            
            let numberOfItems = collectionView.numberOfItems(inSection: section)
            
            guard numberOfItems > 0 else { return }
            
            if numberOfItems > maxElementInSection {
                maxElementInSection = numberOfItems
            }
            // Cycle through each item in the section.
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                // Build the UICollectionVieLayoutAttributes for the cell.
                let cellIndex = IndexPath(item: item, section: section)
                var xPos = 0.0
                var yPos = 0.0
                let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                // item == 0  could change only x position
                if item == 0 {
                    xPos = Double(section) * (cellWidth + cellPadding * 6) + cellPaddingX
                    yPos = Double(yOffset)
                    cellAttributes.frame = CGRect(x: xPos, y: yPos, width: cellWidth + 40, height: cellHeight + 50)
                    // get priority on screen
                    cellAttributes.zIndex = 1
                } else {
                    xPos = Double(section) * (cellWidth + cellPadding * 6) + cellPaddingX * 3
                    yPos = Double(item) * (cellHeight + cellPadding * 2)
                    cellAttributes.frame = CGRect(x: xPos, y: yPos, width: cellWidth, height: cellHeight)
                    cellAttributes.zIndex = 0
                }
                // Save the attributes.
                cellAttribsDictionary[cellIndex] = cellAttributes
            }
        }
        
        // Update content size.
        let contentWidth = Double(collectionView.numberOfSections) * (cellWidth + 6 * cellPadding)
        let contentHeight = Double(maxElementInSection) * (cellHeight + 3 * cellPadding)
        self.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        // Check each element to see if it should be returned.
        for cellAttributes in cellAttribsDictionary.values {
            if cellAttributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(cellAttributes)
            }
        }
        
        // Return list of elements.
        return visibleLayoutAttributes
    }
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
