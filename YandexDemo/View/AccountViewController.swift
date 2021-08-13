//
//  AccountViewController.swift
//  YandexDemo
//
//  Created by Bekzod Khaitboev on 8/1/21.
//

import UIKit


class AccountViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar(animated: animated)
    }
}
