//
//  ViewController.swift
//  Cinemo
//
//  Created by sahapap usadee on 13/10/2566 BE.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(CinemoAPI.shared.enviroment)
        self.testLabel.text = "hello".localized()
        // Do any additional setup after loading the view.
    }
}
