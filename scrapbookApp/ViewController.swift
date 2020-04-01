//
//  ViewController.swift
//  scrapbookApp
//
//  Created by Lauren Banawa on 4/1/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // add plus sign to navigation bar, top right area of screen -- use action addButtonCLicked
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
    }
    
    // action to bring user to detailsVC when plus sign on navigation bar is clicked
    @objc func addButtonClicked() {
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }


}

