//
//  AddExpenseViewController.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/20/24.
//

import UIKit
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class AddExpenseViewController: UIViewController, UINavigationControllerDelegate {
    
    let addExpenseScreen = AddExpenseView()
    let db = Firestore.firestore()
    var currentUser: FirebaseAuth.User?
    let storage = Storage.storage()
    
    // default values
    var selectedCategory = "Personal"
    var pickedImage:UIImage?
    
    override func loadView() {
        view = addExpenseScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Expense"
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
        addExpenseScreen.buttonCategory.menu = getMenuTypes()
        addExpenseScreen.buttonAddPhoto.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        addExpenseScreen.buttonAddExpense.addTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
        addExpenseScreen.buttonCancel.addTarget(self, action: #selector(onCancelButtonTapped), for: .touchUpInside)
    }
    
    //MARK: menu for buttonCategory setup
    func getMenuTypes() -> UIMenu {
        var menuItems = [UIAction]()
        
        // Sort the categories array in alphabetical order
        let sortedCategories = Utilities.categories.sorted()
        
        // Create menu items from the sorted array
        for category in sortedCategories {
            let menuItem = UIAction(title: category, handler: {(_) in
                self.selectedCategory = category
                self.addExpenseScreen.buttonCategory.setTitle(self.selectedCategory, for: .normal)
            })
            menuItems.append(menuItem)
        }
        
        return UIMenu(title: "Select Category", children: menuItems)
    }
    
    
    // MARK: Action for tapping buttonAdd -- adding a new Expense
    @objc func onAddButtonTapped() {
        
        var description: String = ""
        var amount: Double = 0.0
        
        // Validate description text field input
        if let descriptionText = addExpenseScreen.textfieldDescription.text,
           let amountText = addExpenseScreen.textfieldAmount.text {
            
            if !descriptionText.isEmpty {
                description = descriptionText
            } else {
                showErrorAlert(message: "Please add a description.")
                return
            }
            
            // Validate amount text field input
            if !amountText.isEmpty {
                if let uwAmount = Double(amountText) {
                    amount = uwAmount
                } else {
                    showErrorAlert(message: "Please enter a valid amount.")
                    return
                }
            } else {
                showErrorAlert(message: "Please add an amount.")
                return
            }
            
            let image = addExpenseScreen.expenseImageView.image
            let date = addExpenseScreen.pickerDate.date
            
            // Upload the image if it exists
            if let image = image {
                pickedImage = image // Assign the picked image to the property used in uploadExpensePhotoToStorage
                uploadExpensePhotoToStorage { [weak self] imageURL in
                    guard let self = self else { return }
                    
                    // Create newExpense object with the image URL
                    let newExpense = Expense(amount: amount, description: description, category: self.selectedCategory, date: date, imageURL: imageURL)
                    
                    // Convert to dictionary
                    let newExpenseData = newExpense.toDictionary()
                    
                    // Post notification with both newExpense and newExpenseData
                    NotificationCenter.default.post(name: NSNotification.Name("NewExpenseAdded"), object: nil, userInfo: [
                        "newExpense": newExpense,
                        "newExpenseData": newExpenseData
                    ])
                    
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                // Create newExpense object without an image URL
                let newExpense = Expense(amount: amount, description: description, category: selectedCategory, date: date, imageURL: nil)
                
                // Convert to dictionary
                let newExpenseData = newExpense.toDictionary()
                
                // Post notification with both newExpense and newExpenseData
                NotificationCenter.default.post(name: NSNotification.Name("NewExpenseAdded"), object: nil, userInfo: [
                    "newExpense": newExpense,
                    "newExpenseData": newExpenseData
                ])
                
                navigationController?.popViewController(animated: true)
            }
        }
    }
        
        func showErrorAlert(message: String){
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
        // MARK: Cancel button action
        @objc func onCancelButtonTapped() {
            navigationController?.popViewController(animated: true)
        }
        
        func showAlert(message: String) {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }

extension AddExpenseViewController: PHPickerViewControllerDelegate, UIImagePickerControllerDelegate {
    
    @objc func selectPhoto() {
        let alertController = UIAlertController(title: "Select Photo", message: "Choose a photo for your expense", preferredStyle: .actionSheet)
        
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
            addExpenseScreen.expenseImageView.image = image
        }
        picker.dismiss(animated: true)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let result = results.first {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.addExpenseScreen.expenseImageView.image = image
                    }
                }
            }
        }
    }
    
    // MARK: Upload the image to Firebase Storage
    func uploadExpensePhotoToStorage(completion: @escaping (String?) -> Void) {
        // Ensure pickedImage is not nil and convert it to JPEG data
        guard let pickedImage = pickedImage, let jpegData = pickedImage.jpegData(compressionQuality: 0.5) else {
            completion(nil)  // Return nil if image is not picked or data conversion fails
            return
        }
        
        // Create a reference to Firebase Storage
        let storageRef = storage.reference()
        let imagesRepo = storageRef.child("expense_images")
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
