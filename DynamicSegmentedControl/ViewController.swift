//
//  ViewController.swift
//  DynamicSegmentedControl
//
//  Created by Danylo Klymov on 18.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Variables -
    private let items  = ["C++", "C#", "Java", "Swift",  "SQL", "JS", "Python", "TS"]
    private let segmentedControlBackgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
    
    private lazy var segmentedControlButtons: [UIButton] = {
        var segmentedControlButtons: [UIButton] = []
        for item in items {
            let button = UIButton().createSegmentedControlButton(setTitle: item)
            button.addTarget(self,
                             action: #selector(handleSegmentedControlButtons(sender:)),
                             for: .touchUpInside)
            segmentedControlButtons.append(button)
        }
        return segmentedControlButtons
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCustomSegmentedControl()
    }
    
    //MARK: - Private -
    @objc private func handleSegmentedControlButtons(sender: UIButton) {
        for button in segmentedControlButtons {
            if button == sender {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) {
                    button.backgroundColor = .white
                }
            } else {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) { [weak self] in
                    button.backgroundColor = self?.segmentedControlBackgroundColor
                }
            }
        }
    }
    
    private func configureCustomSegmentedControl() {
        segmentedControlButtons.first?.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: segmentedControlButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: .zero, height: 50)
        scrollView.backgroundColor = segmentedControlBackgroundColor
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(stackView)
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    private func configureScrollableSegmentedControl() {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: .zero, height: 50)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(segmentedControl)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 40),
            
            segmentedControl.topAnchor.constraint(equalTo: scrollView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
