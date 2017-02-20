//
//  CardsCollectionViewCell.swift
//  SwipeCardAnimation
//
//  Created by Mac on 13/02/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class CardsCollectionViewCell: UICollectionViewCell {
    
    fileprivate var frontView = UIView()
    fileprivate var backView = UIView()
  
    fileprivate var swipeViewTopConstraints: NSLayoutConstraint!
    fileprivate var swipViewBottomConstraints: NSLayoutConstraint!
    fileprivate var backViewTopConstraints: NSLayoutConstraint!
    fileprivate var backViewBottomConstraints: NSLayoutConstraint!
    fileprivate var backViewLeadingConstraints: NSLayoutConstraint!
    fileprivate var backViewTrailingConstraints: NSLayoutConstraint!
    
    fileprivate var leading: CGFloat = 0.0
    fileprivate var trailing: CGFloat = 0.0
    fileprivate var top: CGFloat = 0.0
    fileprivate var bottom: CGFloat = 0.0

    fileprivate var title = UILabel()
    fileprivate let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.leading = self.contentView.bounds.width/11
        self.trailing = -self.contentView.bounds.width/11
        self.top = self.contentView.bounds.height/4
        self.bottom = -self.contentView.bounds.height/4
        
        setupBackView()
        setupSwipeView()
        setupSwipe()
        setImageView()
        setTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardsCollectionViewCell {
    
    func setupSwipeView() {
        self.contentView.addSubview(self.frontView)
        self.frontView.backgroundColor = .darkGray
        self.frontView.layer.cornerRadius = 7
        self.frontView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.frontView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: leading),
            self.frontView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: trailing)
        ])
        
        swipeViewTopConstraints = self.frontView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: top)
        swipeViewTopConstraints.isActive = true
        swipViewBottomConstraints = self.frontView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: bottom)
        swipViewBottomConstraints.isActive = true
    }
    
    func setupBackView() {
        self.contentView.addSubview(self.backView)
        self.backView.backgroundColor = UIColor.cyan
        self.backView.layer.cornerRadius = 7
        self.backView.translatesAutoresizingMaskIntoConstraints = false
        
        backViewLeadingConstraints = self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: leading)
        backViewLeadingConstraints.isActive = true
        backViewTrailingConstraints = self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: trailing)
        backViewTrailingConstraints.isActive = true
        backViewTopConstraints = self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: top)
        backViewTopConstraints.isActive = true
        backViewBottomConstraints = self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: bottom)
        backViewBottomConstraints.isActive = true
    }
    
    func setupSwipe() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpDone))
        swipeUp.direction = .up
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownDone))
        swipeDown.direction = .down
        
        frontView.addGestureRecognizer(swipeUp)
        frontView.addGestureRecognizer(swipeDown)
    }
    
    func swipeUpDone() {
        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0.5,
            options: .curveLinear,
            animations:
            {
                self.backViewLeadingConstraints.constant = self.leading - 20
                self.backViewTrailingConstraints.constant = self.trailing + 20
                self.backViewTopConstraints.constant = self.top - 30
                self.backViewBottomConstraints.constant = self.bottom + 30
                
                self.swipeViewTopConstraints.constant = self.top - 70
                self.swipViewBottomConstraints.constant = self.bottom - 60
                
                self.contentView.layoutIfNeeded()
        })
    }
    
    func swipeDownDone() {
        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut,
            animations:
            {
                self.backViewLeadingConstraints.constant = self.leading
                self.backViewTrailingConstraints.constant = self.trailing
                self.backViewTopConstraints.constant = self.top
                self.backViewBottomConstraints.constant = self.bottom
                
                self.swipeViewTopConstraints.constant = self.top
                self.swipViewBottomConstraints.constant = self.bottom
                
                self.contentView.layoutIfNeeded()
        })
    }
  
    func setImageView() {
        self.frontView.addSubview(self.imageView)
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 7
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                self.imageView.topAnchor.constraint(equalTo: self.frontView.topAnchor),
                self.imageView.leadingAnchor.constraint(equalTo: self.frontView.leadingAnchor),
                self.imageView.trailingAnchor.constraint(equalTo: self.frontView.trailingAnchor),
                self.imageView.bottomAnchor.constraint(equalTo: self.frontView.bottomAnchor)
        ])
    }
    
    func setTitle() {
        self.frontView.addSubview(self.title)
        self.contentMode = .scaleAspectFit
        self.title.textColor = UIColor.white
        self.title.layer.shadowRadius = 2
        self.title.font = UIFont(name: "Arial", size: 24)
        self.title.layer.shadowOpacity = 0.2
        self.frontView.bringSubview(toFront: self.title)
        self.title.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.title.topAnchor.constraint(equalTo: self.frontView.topAnchor, constant: 16),
            self.title.centerXAnchor.constraint(equalTo: self.frontView.centerXAnchor)
        ])
    }
}

extension CardsCollectionViewCell {
    
    func cellConfig(title: String, image: String) {
        self.title.text = title
        self.imageView.image = UIImage(named: image)
    }
}
