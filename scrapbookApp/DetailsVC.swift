//
//  DetailsVC.swift
//  scrapbookApp
//
//  Created by Lauren Banawa on 4/1/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var chosenPhoto = ""
    var chosenPhotoId : UUID?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if chosenPhoto != ""{
            
            saveButton.isHidden = true // hide the save button when viewing data that has already been saved
            
            // Core Data
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photos")
            let idString = chosenPhotoId?.uuidString
            
            // find the id equal to the idString -- this is better than using the title to identify the data since there may be duplicate titles
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!) // the predicate is used to define logical conditions used to constrain a search for a fetch
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        
                        if let title = result.value(forKey: "title") as? String {
                            titleText.text = title
                        }
                        
                        if let author = result.value(forKey: "author") as? String {
                            authorText.text = author
                        }
                        
                        if let year = result.value(forKey: "year") as? Int {
                            yearText.text = String(year)
                        }
                        
                        if let imageData = result.value(forKey: "image") as? Data {
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                        
                    }
                }
                
            } catch {
                print("error")
            }
            
            
        } else {
            saveButton.isHidden = false
            saveButton.isEnabled = false // do not allow save button to be clicked if user has not chosen an image
            titleText.text = ""
            authorText.text = ""
            yearText.text = ""
        }
        
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
        saveButton.isEnabled = true // only allow save button to be clicked when user chooses an image
        self.dismiss(animated: true, completion: nil) // dismiss picker when finished choosing image
        
    }
    
    // action to follow when tap gesture is recognized -- hide keyboard/ stop editing text field in current view
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        // reach AppDelegate.swift with a variable
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext // NS Managed Object Context
        
        let newPhoto = NSEntityDescription.insertNewObject(forEntityName: "Photos", into: context)
        
        
        // Attributes
        newPhoto.setValue(titleText.text!, forKey: "title")
        newPhoto.setValue(authorText.text!, forKey: "author")
        
        if let year = Int(yearText.text!) {
            newPhoto.setValue(year, forKey: "year")
        }
        newPhoto.setValue(UUID(), forKey: "id") // Universal Unique ID
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPhoto.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("success")
        } catch {
            print ("error")
        }
        
        // send/ show information to user
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    

}
