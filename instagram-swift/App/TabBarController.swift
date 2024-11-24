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
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.white
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        let topLine = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1))
        topLine.backgroundColor = UIColor.secondaryGray
        topLine.autoresizingMask = [.flexibleWidth]
        tabBar.isTranslucent = true
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
            activeIcon: "profilePicture",
            inactiveIcon: "profilePicture",
            vc: ProfileVC()
        )
        
        if let profileImage = UIImage(named: "profilePicture") {
            let circularImage = makeCircularImage(image: profileImage, size: CGSize(width: 30, height: 30))
            profileVC.tabBarItem.image = circularImage?.withRenderingMode(.alwaysOriginal)
            profileVC.tabBarItem.selectedImage = circularImage?.withRenderingMode(.alwaysOriginal)
        }
        
        self.setViewControllers([feedVC, searchVC, addPost, favoriteVC, profileVC], animated: true)
    }
    
    private func configureTab(activeIcon: String, inactiveIcon: String, vc: UIViewController) -> UINavigationController {
        let tab = UINavigationController(rootViewController: vc)
        
        tab.tabBarItem.selectedImage = UIImage(named: activeIcon)
        tab.tabBarItem.image = UIImage(named: inactiveIcon)
        return tab
    }
}


extension TabBarController {
    private func makeCircularImage(image: UIImage, size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let bounds = CGRect(origin: .zero, size: size)
            UIBezierPath(ovalIn: bounds).addClip()
            image.draw(in: bounds)
        }
    }
}
