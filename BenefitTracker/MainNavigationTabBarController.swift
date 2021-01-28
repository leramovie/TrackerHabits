//
//  MainNavigationTabBarController.swift
//  BenefitTracker
//
//  Created by Valery Shel on 08.11.2020.
//

import UIKit

class MainNavigationTabBarController: UITabBarController {
    
    let habitsVC = UINavigationController(rootViewController: HabitsViewController())
    let infoVC = UINavigationController(rootViewController: InfoViewController())

    let habitsBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.image = UIImage(systemName: "rectangle.grid.1x2.fill")
        item.title = "Привычки"
        
        return item
    }()
   
    let infoBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.image = UIImage(systemName: "info.circle.fill")
        item.title = "Информация"
        
        return item
    }()
    
    
    override func viewDidLoad() {
        tabBar.unselectedItemTintColor =  UIColor(named: "SystemGray2")
        tabBar.barTintColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
   
        setupNavigationTabBar()
    }
    
    private func setupNavigationTabBar() {
        
        habitsVC.tabBarItem = habitsBarItem
        infoVC.tabBarItem = infoBarItem
     
        let tabBarList = [habitsVC, infoVC]
        
        viewControllers = tabBarList
    }

}
