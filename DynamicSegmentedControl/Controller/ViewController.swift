//
//  ViewController.swift
//  DynamicSegmentedControl
//
//  Created by Danylo Klymov on 18.03.2022.
//

import UIKit


class ViewController: UIViewController {
    
    //MARK: - Variables -
    var segmentedItems = ["Family", "Work", "MARKET", "HObbie",  "Hunting Club", "AUTO CLUB", "HEATLH CEnter"]
    
    var minimumInteritemSpacing: CGFloat = 1
    var cellTextIndent: CGFloat = 20
    var itemHeight: CGFloat = 50
    
    var textFont: UIFont = .boldSystemFont(ofSize: 17)
    var textColor: UIColor = .blue
    
    var underlineColor: UIColor = .blue
    var collectionViewBackgroundColor: UIColor = .systemGray4
    var cellBackgroundColor: UIColor = .systemGray4
    
    var underlineMovementSpeed: TimeInterval = 0.4

    // Вообще, ожидалось, что вся работа с коллекцией будет вынесена в кастомную вью. Представь, что сейчас будет задача перенести эту вью куда-то в другой проект или на другой экран. как ты будешь это делать??? Такие элементы должны быть переиспользуемыми! Это главный критерий задачи.
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = collectionViewBackgroundColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        return collectionView
    }()
    
    private lazy var itemsPerRow: CGFloat = {
        var itemsPerRow = CGFloat(segmentedItems.count)
        return itemsPerRow
    }()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        capitalizedUserItems()
        setupCollectionView()
        setupSegment()
    }
    
    //MARK: - Private -
    private func setupSegment() {
        let segmentUnderlineWidth: CGFloat = (getSegmentWidth(from: segmentedItems.first!) * itemsPerRow) + cellTextIndent + minimumInteritemSpacing + cellTextIndent
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
        let underlineWidth: CGFloat = getSegmentWidth(from: segmentedItems[selectedSegmentIndex]) + cellTextIndent + minimumInteritemSpacing
        let underlineHeight: CGFloat = 2.0
        let underlineXPosition = (CGFloat(selectedSegmentIndex) * underlineWidth)
        let underLineYPosition = collectionView.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition,
                                    y: underLineYPosition,
                                    width: underlineWidth,
                                    height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = underlineColor
        underline.tag = 1
        collectionView.addSubview(underline)
        view.layoutIfNeeded()
    }
    
    private func changeUnderlinePosition(indexPath: IndexPath) {
        guard let underline = view.viewWithTag(1) else { return }
        UIView.animate(withDuration: underlineMovementSpeed) { [self] in
            var allSkippedCellIntervals: CGFloat = minimumInteritemSpacing
            var skippedSegmentsWidth: CGFloat = 0
            
            if indexPath.item != 0 {
                allSkippedCellIntervals = (cellTextIndent + minimumInteritemSpacing) * CGFloat(indexPath.item)
            }
            
            for item in segmentedItems {
                if item == segmentedItems[indexPath.item] {
                    break
                }
                skippedSegmentsWidth += getSegmentWidth(from: item)
            }
            
            let skippedWidth = allSkippedCellIntervals + skippedSegmentsWidth
            let widthSelectedItem = getSegmentWidth(from: segmentedItems[indexPath.item]) + cellTextIndent
            let xPointCoordinate = skippedWidth + (widthSelectedItem) / CGFloat(2)
            
            underline.frame.size.width = widthSelectedItem
            underline.center.x = xPointCoordinate
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupCollectionView() {
        layoutCollectionView()
        registerCollectionViewCell()
    }
    
    private func registerCollectionViewCell() {
        SegmentCollectionViewCell.register(in: collectionView)
        collectionView.reloadData()
    }
    
    private func layoutCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 35),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: 80)
        ])
    }
    
    private func getSegmentWidth(from segment: String) -> CGFloat {
        return segment.size(withAttributes: [NSAttributedString.Key.font: textFont]).width
    }
    
    private func capitalizedUserItems() {
        segmentedItems = segmentedItems.map{$0.capitalized}
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
        let cell = SegmentCollectionViewCell.dequeueCellWithType(in: collectionView,
                                                                 indexPath: indexPath)
        let title = segmentedItems[indexPath.item]
        let textOptions = (title, textFont, textColor)
        cell.configure(textOptions: textOptions,
                       cellBackgroundColor: cellBackgroundColor)
        return cell
    }
}

// MARK: - UICollectionViewDelegate -
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        changeUnderlinePosition(indexPath: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: getSegmentWidth(from: segmentedItems[indexPath.item]) + cellTextIndent, height: itemHeight)
    }
}

// Ты никак не обработал скролл элемента. при скролле элемента у меня элемент остаётся на том же месте, относительно рамок экрана. индикатор должен держаться того элемента, который выбран.

// У тебя есть еще какие-то артефакты (то ли несколько раз добавленный как сабвью сегмент, то ли что-то еще. посмотри на видео, как это выглядит. видео отправлю лично.
