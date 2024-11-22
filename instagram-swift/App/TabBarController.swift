//
//  TabBarControllerViewController.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupTabBarController()
    }
    
    private func setupTabBar() {
        self.tabBar.tintColor = .primaryBlack
        self.tabBar.unselectedItemTintColor = .primaryBlack
        self.tabBar.backgroundColor = .tabBarCol
        
        let topLine = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1))
        topLine.backgroundColor = UIColor.secondaryGray
        topLine.autoresizingMask = [.flexibleWidth]

        tabBar.addSubview(topLine)
    }
    
    private func setupTabBarController() {
        let feedVC = configureTab(
            activeIcon: "homeActive",
            inactiveIcon: "homeInactive",
            vc: FeedVC()
        )
        
        let searchVC = configureTab(
            activeIcon: "searchActive",
            inactiveIcon: "searchInactive",
            vc: SearchVC()
        
        )
        let addPost = configureTab(
            activeIcon: "addButoon",
            inactiveIcon: "addButoon",
            vc: AddPostVC()
        )
        
        let favoriteVC = configureTab(
            activeIcon: "heartActive",
            inactiveIcon: "heartInactive",
            vc: LikesVC()
        )
        
        let profileVC = configureTab(
            activeIcon: "testUser",
            inactiveIcon: "testUser",
            vc: ProfileVC()
        )
        
        self.setViewControllers([feedVC, searchVC, addPost, favoriteVC, profileVC], animated: true)
    }
    
    private func configureTab(activeIcon: String, inactiveIcon: String, vc: UIViewController) -> UINavigationController {
        let tab = UINavigationController(rootViewController: vc)
        
        tab.tabBarItem.selectedImage = UIImage(named: activeIcon)
        tab.tabBarItem.image = UIImage(named: inactiveIcon)
        return tab
    }
}
