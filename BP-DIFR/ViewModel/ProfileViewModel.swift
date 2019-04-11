//
//  ProfileViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 02/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import FirebaseUI
import HealthKit

class ProfileViewModel: UIViewController {

    // TABLE VIEW
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var biologicalSexLabel: UILabel!
    @IBOutlet weak var bloodTypeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var bodyMassIndexLabel: UILabel!
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tapToChangeProfileButton: UIButton!
//    @IBAction func changeImageIconTapped(_ sender: Any) {
//        handleImageUpload()
//    }
    
    
    private let userHealthProfile = UserHealthProfile()
    
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

// MARK: TableView
extension ProfileViewModel: UITableViewDelegate {
    private enum ProfileSection: Int {
        case ageSexBloodType
        case weightHeightBMI
        case readHealthKitData
        case saveBMI
    }
    
    private enum ProfileDataError: Error {
        case missingBodyMassIndex
        
        var localizedDescription: String {
            switch self {
            case .missingBodyMassIndex:
                return "Unable to calculate body mass index with available profile data."
            }
        }
    }
    
    private func updateHealthInfo() {
        loadAndDisplayAgeSexAndBloodType()
        loadAndDisplayMostRecentWeight()
        loadAndDisplayMostRecentHeight()
    }
    
    private func loadAndDisplayAgeSexAndBloodType() {
        do {
            let userAgeSexAndBloodType = try ProfileDataStore.getAgeSexAndBloodType()
            userHealthProfile.age = userAgeSexAndBloodType.age
            userHealthProfile.biologicalSex = userAgeSexAndBloodType.biologicalSex
            userHealthProfile.bloodType = userAgeSexAndBloodType.bloodType
            updateLabels()
        } catch let error {
            displayAlert(for: error)
        }
    }
    
    private func updateLabels() {
        if let age = userHealthProfile.age {
            ageLabel.text = "\(age)"
        }
        
        if let biologicalSex = userHealthProfile.biologicalSex {
            biologicalSexLabel.text = biologicalSex.stringRepresentation
        }
        
        if let bloodType = userHealthProfile.bloodType {
            bloodTypeLabel.text = bloodType.stringRepresentation
        }
        
        if let weight = userHealthProfile.weightInKilograms {
            let weightFormatter = MassFormatter()
            weightFormatter.isForPersonMassUse = true
            weightLabel.text = weightFormatter.string(fromKilograms: weight)
        }
        
        if let height = userHealthProfile.heightInMeters {
            let heightFormatter = LengthFormatter()
            heightFormatter.isForPersonHeightUse = true
            heightLabel.text = heightFormatter.string(fromMeters: height)
        }
        
        if let bodyMassIndex = userHealthProfile.bodyMassIndex {
            bodyMassIndexLabel.text = String(format: "%.02f", bodyMassIndex)
        }
    }
    
    private func loadAndDisplayMostRecentHeight() {
        //1. Use HealthKit to create the Height Sample Type
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
            print("Height Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: heightSampleType) { (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.displayAlert(for: error)
                }
                
                return
            }
            
            //2. Convert the height sample to meters, save to the profile model,
            //   and update the user interface.
            let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
            self.userHealthProfile.heightInMeters = heightInMeters
            self.updateLabels()
        }
    }
    
    private func loadAndDisplayMostRecentWeight() {
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
            print("Body Mass Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: weightSampleType) { (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.displayAlert(for: error)
                }
                return
            }
            
            let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            self.userHealthProfile.weightInKilograms = weightInKilograms
            self.updateLabels()
        }
    }
    
    private func saveBodyMassIndexToHealthKit() {
        guard let bodyMassIndex = userHealthProfile.bodyMassIndex else {
            displayAlert(for: ProfileDataError.missingBodyMassIndex)
            return
        }
        
        ProfileDataStore.saveBodyMassIndexSample(bodyMassIndex: bodyMassIndex,
                                                 date: Date())
    }
    
    private func displayAlert(for error: Error) {
        let alert = UIAlertController(title: nil,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "O.K.",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = ProfileSection(rawValue: indexPath.section) else {
                fatalError("A ProfileSection should map to the index path's section")
            }

            switch section {
            case .saveBMI:
                saveBodyMassIndexToHealthKit()
            case .readHealthKitData:
                updateHealthInfo()
            default: break
            }
    }
}
