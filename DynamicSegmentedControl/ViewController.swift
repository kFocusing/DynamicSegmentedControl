//
//  ViewController.swift
//  DynamicSegmentedControl
//
//  Created by Danylo Klymov on 18.03.2022.
//

import UIKit


class ViewController: UIViewController {
    
    //MARK: - Variables -
    private let segmentedItems = ["C++", "C#", "Java", "Swift",  "SQL", "JS", "Python", "TS"]
    private var collectionView: UICollectionView!
    private lazy var itemsPerRow: CGFloat = {
        var itemsPerRow = CGFloat(segmentedItems.count)
        return itemsPerRow
    }()
    private let itemSize = CGSize(width: 100, height: 50)
    
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSegment()
    }
    
    //MARK: - Private -
    private func setupSegment() {
        let segmentUnderlineWidth: CGFloat = itemSize.width * itemsPerRow
        let segmentUnderlineHeight: CGFloat = 2.0
        let segmentUnderlineXPosition = collectionView.bounds.minX
        let segmentUnderLineYPosition = collectionView.bounds.size.height - 1.0
        let segmentUnderlineFrame = CGRect(x: segmentUnderlineXPosition,
                                           y: segmentUnderLineYPosition,
                                           width: segmentUnderlineWidth,
                                           height: segmentUnderlineHeight)
        let segmentUnderline = UIView(frame: segmentUnderlineFrame)
        segmentUnderline.backgroundColor = UIColor.clear

        collectionView.addSubview(segmentUnderline)
        view.layoutIfNeeded()
        addUnderlineForSelectedSegment(selectedSegmentIndex: 0)
    }

    private func addUnderlineForSelectedSegment(selectedSegmentIndex: Int) {
        let underlineWidth: CGFloat = itemSize.width * itemsPerRow / CGFloat(itemsPerRow)
        let underlineHeight: CGFloat = 2.0
        let underlineXPosition = CGFloat(selectedSegmentIndex) * underlineWidth
        let underLineYPosition = collectionView.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition,
                                    y: underLineYPosition,
                                    width: underlineWidth,
                                    height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor.blue
        underline.tag = 1
        collectionView.addSubview(underline)
        view.layoutIfNeeded()
    }
    
    private func changeUnderlinePosition(indexPath: IndexPath) {
        guard let underline = view.viewWithTag(1) else {return}
        let underlineFinalXPosition = ((itemSize.width * itemsPerRow) / CGFloat(itemsPerRow)) * CGFloat(indexPath.row)
        underline.frame.origin.x = underlineFinalXPosition
        view.layoutIfNeeded()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 0
        layout.itemSize = itemSize
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 35),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: 80)
        ])
        
        PlaceCollectionViewCell.register(in: collectionView)
        collectionView.reloadData()
    }
}

// MARK: - Extensions -
// MARK: - UICollectionViewDataSource -
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return segmentedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = PlaceCollectionViewCell.dequeueCellWithType(in: collectionView, indexPath: indexPath)
        let title = segmentedItems[indexPath.item]
        cell.configure(with: title)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate -
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        changeUnderlinePosition(indexPath: indexPath)
    }
}
