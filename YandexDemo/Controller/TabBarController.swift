//
//  TabBarController.swift
//  YandexDemo
//
//  Created by Bekzod Khaitboev on 8/1/21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let bookmarkVC = BookmarkViewController()
        let locationVC = LocationViewController()
        let accountVC = AccountViewController()
        

        self.setViewControllers([bookmarkVC, locationVC, accountVC], animated: true)
        guard let items = self.tabBar.items else { return }
        let images = ["bookmark_Icon", "location_Icon", "Account_Icon"]
        for imageName in 0...2 {
            items[imageName].image = UIImage(named: images[imageName])
        }
        
        self.tabBar.tintColor = .black
    }

}
