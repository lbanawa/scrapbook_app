//
//  DetailsVC.swift
//  scrapbookApp
//
//  Created by Lauren Banawa on 4/1/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Recognizers
        
        // hide keyboard when tap gesture is recognized anywhere in the view
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        // imageView gesture recognizer to upload an image
        imageView.isUserInteractionEnabled = true // allow imageView to be interacted with
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage)) // refer to selectImage action
        imageView.addGestureRecognizer(imageTapRecognizer) // add tap gesture recognizer to imageView object
        
    }
    
    @objc func selectImage() {
        // UIImagePickerContoller gives access to managing images and videos -- use to access user's media library
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true // if user selects an image, they have the ability to edit it (ex. zoom, crop, etc.)
        present(picker, animated: true, completion: nil) // present the picker in an animated style, do not do anything upon completion
        
    }
    
    // tells the delegate that the user picked an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage // cast it optionally as a UIImage in case user uploads invalid file or cancels upload
        self.dismiss(animated: true, completion: nil) // dismiss picker when finished choosing image
        
    }
    
    // action to follow when tap gesture is recognized -- hide keyboard/ stop editing text field in current view
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        print("test")
    }
    

}
