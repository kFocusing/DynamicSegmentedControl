//
//  PlaceCollectionViewCell.swift
//  DynamicSegmentedControl
//
//  Created by Danylo Klymov on 23.03.2022.
//

import UIKit

class PlaceCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - Variables -
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemGray4
        contentView.addSubview(view)
        return view
    }()
    private lazy var title: UILabel = {
        let label = UILabel()
        // Зачем здесь делать лейблу динамически расширяемой по высоте? у тебя ж высота ячейки будет ограниченной. растягивать как раз таки нужно по ширине
        label.numberOfLines = 0
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        contentView.addSubview(label)
        return label
    }()
    
    //MARK: - Life Cycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIElements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUIElements()
    }
    
    //MARK: - Internal -
    func configure(with title: String) {
        setupTitle(with: title)
    }
    
    //MARK: - Private -
    private func setupUIElements() {
        layoutContainer()
        layoutLabel()
    }
    private func layoutContainer() {
        containerView.pinEdges(to: self.contentView)
    }
    
    private func layoutLabel() {
        // А если название будет длинным? оно будет вылазить за пределы ячейки. а ячейка должна растягиваться по горизонтали, в зависимости от контента
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    private func setupTitle(with title: String) {
        // Лучше здесь обработать регистр тайтла. Определиться: будет ли апперкейс, или просто капиталайзед (начинается с большой буквы), и применить его. чтоб все элементы были в одном формате, независимо от формата входящих данных
        self.title.text = title
    }
}
