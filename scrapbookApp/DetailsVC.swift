//
//  DetailsVC.swift
//  scrapbookApp
//
//  Created by Lauren Banawa on 4/1/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // hide keyboard when tap gesture is recognized anywhere in the view
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    // action to follow when tap gesture is recognized -- hide keyboard/ stop editing text field in current view
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        print("test")
    }
    

}
