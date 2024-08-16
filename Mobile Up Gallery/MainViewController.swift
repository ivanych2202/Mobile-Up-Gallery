//
//  MainViewController.swift
//  Mobile Up Gallery
//
//  Created by Ivan Elonov on 15.08.2024.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "MobileUp Gallery"
        
        let exitButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(exitButtonPressed))
        exitButton.tintColor = .black
        navigationItem.rightBarButtonItem = exitButton
    }

    @objc func exitButtonPressed() {
        self.dismiss(animated: true)
    }

}
