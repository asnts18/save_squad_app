//
//  CreateSavingsGoalViewController.swift
//  SaveSquadApp
//
//  Created by Haritha Selvakumaran on 11/7/24.
//
import UIKit
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class CreateSavingsGoalViewController: UIViewController, PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let createSavingsGoalView = CreateSavingsGoalView()
    let storage = Storage.storage()
    var pickedImage: UIImage?
    let childProgressView = ProgressSpinnerViewController()

    override func loadView() {
        view = createSavingsGoalView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Goal"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = Utilities.purple
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        let smallTitleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = smallTitleAttributes
        self.navigationController?.navigationBar.tintColor = .white
        createSavingsGoalView.addPhotoButton.addTarget(self, action: #selector(onAddPhotoButtonTapped), for: .touchUpInside)
        createSavingsGoalView.createGoalButton.addTarget(self, action: #selector(onCreateGoalButtonTapped), for: .touchUpInside)
        createSavingsGoalView.cancelButton.addTarget(self, action: #selector(onCancelButtonTapped), for: .touchUpInside)
    }
        
    @objc func onAddPhotoButtonTapped() {
        let alertController = UIAlertController(title: "Select Photo", message: "Choose a photo for your goal", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
            self.openCamera()
        })
        
        alertController.addAction(UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.openPhotoLibrary()
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertController, animated: true)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true)
        }
    }
    
    private func openPhotoLibrary() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            createSavingsGoalView.goalImageView.image = image
            pickedImage = image // Save the picked image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let result = results.first {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.createSavingsGoalView.goalImageView.image = image
                        self?.pickedImage = image // Save the picked image
                    }
                }
            }
        }
    }

    @objc func onCreateGoalButtonTapped() {
        showActivityIndicator()
        guard let name = createSavingsGoalView.nameTextField.text, !name.isEmpty,
              let description = createSavingsGoalView.descriptionTextField.text, !description.isEmpty,
              let costText = createSavingsGoalView.amountTextField.text, let cost = Double(costText) else {
            let alert = UIAlertController(title: "Error", message: "Please fill all fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let targetDate = createSavingsGoalView.targetDatePicker.date
        // Check if an image was selected
        if let image = createSavingsGoalView.goalImageView.image {
            pickedImage = image // Assign the picked image to the property used in uploadGoalPhotoToStorage
            uploadGoalPhotoToStorage { [weak self] imageURL in
                guard let self = self else {return }
                
                // Create newGoal object with the image URL
                let newGoal = SavingsGoal(name: name, description: description, cost: cost, targetDate: targetDate, imageURL: imageURL)
                
                // Convert to dictionary
                let newGoalData = newGoal.toDictionary()
                
                // Post notification with both newExpense and newExpenseData
                NotificationCenter.default.post(name: NSNotification.Name("NewGoalAdded"), object: nil, userInfo: [
                    "newGoal": newGoal,
                    "newGoalData": newGoalData
                ])
                
                // Pop the view controller
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            // Create newGoal object without an image URL
            let newGoal = SavingsGoal(name: name, description: description, cost: cost, targetDate: targetDate, imageURL: nil)
            
            // Convert to dictionary
            let newGoalData = newGoal.toDictionary()
            
            // Post notification with both newExpense and newExpenseData
            NotificationCenter.default.post(name: NSNotification.Name("NewGoalAdded"), object: nil, userInfo: [
                "newGoal": newGoal,
                "newGoalData": newGoalData
            ])
            
            // Pop the view controller
            navigationController?.popViewController(animated: true)
        }
    }

    
    @objc func onCancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func uploadGoalPhotoToStorage(completion: @escaping (String?) -> Void) {
        // Ensure pickedImage is not nil and convert it to JPEG data
        guard let pickedImage = pickedImage, let jpegData = pickedImage.jpegData(compressionQuality: 0.5) else {
            completion(nil)  // Return nil if image is not picked or data conversion fails
            return
        }
        
        // Create a reference to Firebase Storage
        let storageRef = storage.reference()
        let imagesRepo = storageRef.child("goal_images")
        let imageRef = imagesRepo.child("\(UUID().uuidString).jpg")
        
        // Upload image data to Firebase Storage
        imageRef.putData(jpegData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil)  // Return nil if upload fails
                return
            }
            
            // Get the download URL for the uploaded image
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Error fetching download URL: \(error.localizedDescription)")
                    completion(nil)  // Return nil if fetching URL fails
                } else {
                    completion(url?.absoluteString)  // Return the image URL on success
                }
            }
        }
    }

}

