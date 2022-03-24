//
//  ButtonExtension.swift
//  DynamicSegmentedControl
//
//  Created by Danylo Klymov on 21.03.2022.
//

import UIKit

// Экстеншн нигде не используется. удалить
extension UIButton {
    func createSegmentedControlButton(setTitle title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }
}
