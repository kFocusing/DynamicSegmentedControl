//
//  CellReusable.swift
//  DynamicSegmentedControl
//
//  Created by Danylo Klymov on 23.03.2022.
//

import UIKit

protocol CollectionCellDequeueReusable: UICollectionViewCell { }

protocol CollectionCellRegistable: UICollectionViewCell { }

extension CollectionCellRegistable {
    static func register(in collectionView: UICollectionView) {
        collectionView.register(Self.self, forCellWithReuseIdentifier: String(describing: self))
    }
}

extension CollectionCellDequeueReusable {
    static func dequeueCellWithType(in collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Self.self),
                                                  for: indexPath) as! Self
    }
}
