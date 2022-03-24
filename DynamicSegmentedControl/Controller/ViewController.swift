//
//  ViewController.swift
//  DynamicSegmentedControl
//
//  Created by Danylo Klymov on 18.03.2022.
//

import UIKit


class ViewController: UIViewController {
    
    //MARK: - Variables -
    private let segmentedItems = ["C++", "C#", "Java", "Swift",  "SQL", "JS", "Python", "Multithreading"]
    
    // Вообще, ожидалось, что вся работа с коллекцией будет вынесена в кастомную вью. Представь, что сейчас будет задача перенести эту вью куда-то в другой проект или на другой экран. как ты будешь это делать??? Такие элементы должны быть переиспользуемыми! Это главный критерий задачи.
    private var collectionView: UICollectionView!
    private lazy var itemsPerRow: CGFloat = {
        var itemsPerRow = CGFloat(segmentedItems.count)
        return itemsPerRow
    }()
    // а почему размер фиксированный? если текст будет длинный, что будет с сегментом? текст будет троиточиться? в твоём случае, увеличится высота, потому что там лейбла имеет numberOfLines = 0. это неправильно
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
        
        // 1) при работе с коллекцией нужно использовать indexPath.item, a не indexPath.row
        // 2) неправильный подход к высчитывании позиции
        // 3) ты не центрируешь, а задаёшь стартовый origin.х - это тоже неправильно
        // 4) нет анимации . анимация - ключевой момент !
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

// Ты никак не обработал скролл элемента. при скролле элемента у меня элемент остаётся на том же месте, относительно рамок экрана. индикатор должен держаться того элемента, который выбран.

// У тебя есть еще какие-то артефакты (то ли несколько раз добавленный как сабвью сегмент, то ли что-то еще. посмотри на видео, как это выглядит. видео отправлю лично.