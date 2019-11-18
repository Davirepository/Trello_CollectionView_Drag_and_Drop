//
//  CollectionViewController.swift
//  HW_CollectionView_Trello
//
//  Created by Давид on 07/11/2019.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

@objc class CollectionViewController: UIViewController {
    
    @objc var collectionView: UICollectionView!
    var dataSource = DataSource()
    let layout = CustomLayout()
    var newCell = NewCellViewController()
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
        navigationController?.isNavigationBarHidden = true
        
        self.view.addSubview(collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        updateLayout(with: view.frame.size)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.updateLayout(with: self.view.frame.size)
        }, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.updateLayout(with: self.view.frame.size)
    }
    
    private func updateLayout(with size: CGSize) {
        collectionView.frame = CGRect.init(origin: .zero, size: size)
        collectionView.reloadData()
    }
    
    ///fileprivate
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView)
    {
        // element
        let items = coordinator.items
        if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath
        {
            var dIndexPath = destinationIndexPath
            if dIndexPath.row >= collectionView.numberOfItems(inSection: dIndexPath.section)
            {
                dIndexPath.row = collectionView.numberOfItems(inSection: dIndexPath.section)
            }
            collectionView.performBatchUpdates({
                dataSource.data.data[sourceIndexPath.section].remove(at: sourceIndexPath.row)
                dataSource.data.data[dIndexPath.section].insert(item.dragItem.localObject as! String, at: dIndexPath.row)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [dIndexPath])
                collectionView.reloadData()
            })
            collectionView.reloadData()
            coordinator.drop(items.first!.dragItem, toItemAt: dIndexPath)
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item != 0 else {
//            self.indexPath = indexPath
//            let view = NewCellViewController().viewForTask()
//            view.delegate = self
//            self.newCell = view
//
//            collectionView.superview?.addSubview(newCell)
//            collectionView.isUserInteractionEnabled = false
            dataSource.data.data[indexPath.section].append("")
            collectionView.reloadData()
            return }
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        if cell.titleTextView.hasText && dataSource.data.data[indexPath.section][indexPath.last!] == "" {
            dataSource.data.data[indexPath.section][indexPath.row] = cell.titleTextView.text
            dataSource.data.data[indexPath.section].append("")
        } else if cell.titleTextView.text != "" && dataSource.data.data[indexPath.section].count < 3 && dataSource.data.data[indexPath.section][indexPath.last!] != "" {
            dataSource.data.data[indexPath.section].append("")
        } else if cell.titleTextView.isEditable {
            if cell.titleTextView.text != "" && dataSource.data.data[indexPath.section].count > 2{
                dataSource.data.data[indexPath.section][indexPath.row] = cell.titleTextView.text
            }  else if dataSource.data.data[indexPath.section].count > 2 && cell.titleTextView.text == "" {
            dataSource.data.data[indexPath.section].remove(at: indexPath.item)
            } else {
                dataSource.data.data[indexPath.section][indexPath.row] = ""
            }
        }
        
        collectionView.reloadData()
        print(dataSource.data)
        
    }
}

extension CollectionViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard indexPath.item != 0 else { return[] }
        let item = self.dataSource.data.data[indexPath.section][indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
}

extension CollectionViewController: UICollectionViewDropDelegate {
    
    // проверем возможность дропа определенного типа
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool
    {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    // можем дропнуть объект
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
    {
        if collectionView.hasActiveDrag
        {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        else
        {
            // ничего не выполнится
            return UICollectionViewDropProposal(operation: .forbidden)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            guard indexPath.item != 0 else { return }
            destinationIndexPath = indexPath
        } else {
            // Get x coordination to where we rotate our rectangle
            let xLocation = coordinator.session.location(in: collectionView).x
            //calculate size of section(get such size because widh = fame.width)
            var cellFrame = CGFloat(UIScreen.main.bounds.width)
            var section = 0
            let frame = CGFloat(UIScreen.main.bounds.width)
            // summ cellFrame to find nessecary poin x
            for _ in 1...collectionView.numberOfSections{
                if cellFrame <= xLocation {
                    cellFrame += frame
                    section += 1
                }
            }
            let rows = collectionView.numberOfItems(inSection: section) + 1
            destinationIndexPath = IndexPath(row: rows, section: section)
        }
        
        switch coordinator.proposal.operation {
        case .move:
            self.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
            break
        default:
            return
        }
    }
}

extension CollectionViewController: NewCellViewControllerDelegate {
    func cellViewDidTapClose(_ view: NewCellViewController) {
        view.removeFromSuperview()
        self.collectionView.isUserInteractionEnabled = true
    }
    
    func cellViewDidTapSave(_ view: NewCellViewController, saveText textview: String) {
        if textview != "" {
            dataSource.data.data[self.indexPath!.section].append(textview)
        }
        dataSource.data.data[self.indexPath!.section].append(textview)
        view.removeFromSuperview()
        self.collectionView.isUserInteractionEnabled = true
    }
    
}
