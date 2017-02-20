//
//  ViewController.swift
//  SwipeCard
//
//  Created by Mac on 14/02/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var collectionView: UICollectionView!
    fileprivate var homeVM: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        self.homeVM = ViewModel(homeViewController: self)

        setupCollectionView()
    }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var insets = self.collectionView.contentInset
        let setValue = (self.view.frame.size.width - (
            self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            ).itemSize.width) * 0.5
        insets.left = setValue
        insets.right = setValue
        self.collectionView.contentInset = insets
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let cellWidth = self.collectionView.bounds.width - self.collectionView.bounds.width/3.5
        self.collectionView.setContentOffset(
            CGPoint(
                x: -(self.collectionView.bounds.width/2.0) + (cellWidth/2.0),
                y: 0
            ),
            animated: true
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: self.view.bounds.width,
                height: self.view.bounds.height),
            collectionViewLayout: layout
        )
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.isPagingEnabled = false
        self.collectionView.backgroundColor = UIColor.gray
        self.collectionView.register(
            CardsCollectionViewCell.self,
            forCellWithReuseIdentifier: "MyCell"
        )

        self.view.addSubview(self.collectionView)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return  homeVM.numberOfItems()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(
            withReuseIdentifier: "MyCell",
            for: indexPath) as! CardsCollectionViewCell
        cell.cellConfig(
            title: homeVM.getTitle(index: indexPath.row),
            image: homeVM.getImageTitle(index: indexPath.row))
        
        return cell
    }
}

extension ViewController:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: self.collectionView.bounds.width - self.collectionView.bounds.width/3.5,
                      height: self.collectionView.bounds.height)
    }
}

extension ViewController {
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var distance: CGFloat?
        let contentOffset = targetContentOffset.pointee
        let centerX = contentOffset.x + self.collectionView.bounds.width/2.0
        
        for cell in self.collectionView.visibleCells {
            if distance == nil {
                distance = centerX - cell.center.x
            } else if fabs(centerX - cell.center.x) < fabs(distance!) {
                distance = centerX - cell.center.x
            }
        }
        let newPoint = CGPoint(x: contentOffset.x - distance!, y: 0)
        targetContentOffset.pointee = newPoint
    }
}
