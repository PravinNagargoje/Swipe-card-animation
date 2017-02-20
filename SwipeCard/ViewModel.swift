//
//  ViewModel.swift
//  SwipeCard
//
//  Created by Mac on 14/02/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation

class ViewModel {
    
    fileprivate var countriesArray = ["Norway","India","USA","Japan","Canada"]
    fileprivate var countriesImageArray = ["norway","india","usa","japan","canada"]
    fileprivate var homeVC: ViewController!

    init(homeViewController: ViewController) {
        homeVC = homeViewController
    }
    
    func numberOfItems() -> Int {
        return countriesArray.count
    }
    
    func getTitle(index: Int) -> String {
        return countriesArray[index]
    }
    
    func getImageTitle(index: Int) -> String {
        return countriesImageArray[index]
    }
 
}
