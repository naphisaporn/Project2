//
//  NewBlogViewController.swift
//  Myorchard
//
//  Created by PewPew on 7/5/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

class NewBlogViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var mainImageButton: UIButton!
    @IBOutlet weak var firstImageButton: UIButton!
    @IBOutlet weak var secondImageButton: UIButton!
    
    private var currentButton: UIButton?
    
    var firestore: FirestoreService!
    let storage = StorageService.shared
    
    private lazy var pickerController: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(firestore)
        print(storage)

        pickerController.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dissmissKeyboard() {
        titleTextField.endEditing(true)
    }
    
    @IBAction func getPhoto(_ sender: UIButton) {
        currentButton = sender
        present(pickerController, animated: true)
    }
    
    @IBAction func saveBlog(_ sender: Any) {
        guard let title = titleTextField.text,
            let mainImage = mainImageButton.backgroundImage(for: .normal),
            let firstImage = firstImageButton.backgroundImage(for: .normal),
        let secondImage = secondImageButton.backgroundImage(for: .normal)
        else { return }
        
        storage.bulkUpload([mainImage, firstImage, secondImage]) { [weak self] (urlPaths) in
            let blog = Blog(mainImagePath: urlPaths[0], title: title, otherImagePaths: [urlPaths[1], urlPaths[2]])
            
            self?.firestore.save(blog) { (result) in
                print(result)
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    
}

extension NewBlogViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard  let image = info[.originalImage] as? UIImage else {
            return
        }
        currentButton!.setBackgroundImage(image, for: .normal)
    }
}
