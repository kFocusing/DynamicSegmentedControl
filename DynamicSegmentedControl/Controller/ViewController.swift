//
//  ViewController.swift
//  DynamicSegmentedControl
//
//  Created by Danylo Klymov on 18.03.2022.
//

import UIKit


class ViewController: UIViewController {
    
    private lazy var dynamicSegmentedControl: DynamicSegmentedControl = {
        let dynamicSegmentedControl = DynamicSegmentedControl()
        let segmentArray = ["Hello", "Home", "YANKEE", "mAster SporT", "All poland childs like work"]
        dynamicSegmentedControl.configure(with: segmentArray)
        return dynamicSegmentedControl
    }()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        dynamicSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        layoutDynamicSegmentedControl()
    }
    
    private func layoutDynamicSegmentedControl() {
        view.addSubview(dynamicSegmentedControl)
        NSLayoutConstraint.activate([
            dynamicSegmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            dynamicSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dynamicSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dynamicSegmentedControl.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        ])
    }
}
