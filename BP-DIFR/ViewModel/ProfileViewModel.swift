//
//  ProfileViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 02/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import FirebaseUI

class ProfileViewModel: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tapToChangeProfileButton: UIButton!
//    @IBAction func changeImageIconTapped(_ sender: Any) {
//        handleImageUpload()
//    }
    
    
    
    var imagePicker: UIImagePickerController!
    
    @IBAction func logOutTapped(_ sender: Any) {
        handleSignOut()
    }
    
    func handleSignOut() {
        do {
            try! Auth.auth().signOut()
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        db = Firestore.firestore()
        
        guard let image = profileImageView.image else { return }
//        handleImageUpload(image) { (url) in
//            <#code#>
//        }
        
        // Tap gesture na obrazok, po kliknuti sa otvori image picker
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(imageTap)
        
        // nastavenie okruhleho dizajnu na image
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.clipsToBounds = true
        
        // tap target na otvorenie pickera
        tapToChangeProfileButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
    }
    
    func handleImageUpload(_ image: UIImage, completion: @escaping ((_ url: String?)->())) {
        // Ref na usera
      
        // Ref na storage
      
//        
//        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
//      
//        metaData.contentType = "image/jpg"
//        
//        storageRef.putData(imageData, metadata: metaData) { (metaData, error) in
//            if error == nil, metaData != nil {
//                // success
//                storageRef.downloadURL(completion: { (url, error) in
//                    completion(url?.absoluteString)
//                })
//                
//            } else {
//                // failed
//                completion(nil)
//            }
//        }
    }
    
    @objc func openImagePicker(_ sender: Any) {
        self.present(imagePicker,animated: true,completion: nil)
    }
    
    func saveProfile(username: String, profileImageURL: URL, completion: @escaping ((_ success: Bool)->())) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let databaseRef = db.collection("users")
    }
}

extension ProfileViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // nastavenie imagu ktory zvolil user
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImageView.image = pickedImage
        }
        
        // po vybrati picker zmizne
        picker.dismiss(animated: true, completion: nil)
    }
}
