//
//  LikesControlButton.swift
//  less_1_IOS
//
//  Created by elf on 15.02.2021.
//

import UIKit
final class LikesButton: UIControl {
    enum State {
        case liked(Int)
        case disliked(Int)
    }

    let imageView = UIImageView()
    let numberOfLikesLabel = UILabel()

    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted != oldValue {
                self.alpha = self.isHighlighted ? 0.7 : 1
            }
        }
    }

    init(initialState: State) {
        super.init(frame: .zero)

        self.addSubview(self.imageView)
        self.addSubview(self.numberOfLikesLabel)
    
        self.applyState(initialState)

        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        self.numberOfLikesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLikesLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 4).isActive = true
        self.numberOfLikesLabel.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: 4).isActive = true
        self.numberOfLikesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applyState(_ state: State) {
        switch state {
        case let .liked(likes):
            self.numberOfLikesLabel.text = "\(likes)"
            self.imageView.image = UIImage(systemName: "heart.fill")
            self.imageView.backgroundColor = .yellow
        case let .disliked(likes):
            self.numberOfLikesLabel.text = "\(likes)"
            self.imageView.image = UIImage(systemName: "heart")
            self.imageView.backgroundColor = .white
        }
    }
}
