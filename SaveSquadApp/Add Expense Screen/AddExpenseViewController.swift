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

class AddExpenseViewController: UIViewController, UINavigationControllerDelegate {
    
    let addExpenseScreen = AddExpenseView()
    let db = Firestore.firestore()
    var currentUser: FirebaseAuth.User?
    
    // default values
    var selectedCategory = "Personal"
    var pickedImage = UIImage(systemName: "photo")
    
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
    func getMenuTypes() -> UIMenu{
        var menuItems = [UIAction]()
        
        for category in Utilities.categories{
            let menuItem = UIAction(title: category, handler: {(_) in
                self.selectedCategory = category
                self.addExpenseScreen.buttonCategory.setTitle(self.selectedCategory, for: .normal)
            })
            menuItems.append(menuItem)
        }
        
        return UIMenu(title: "Select Category", children: menuItems)
    }
    
    
    
    //MARK: action for tapping buttonAdd -- adding a new Expense
    @objc func onAddButtonTapped() {
        
        var description:String = ""
        var amount:Double = 0.0
        
        // validate description text field input
        if let descriptionText = addExpenseScreen.textfieldDescription.text,
           let amountText = addExpenseScreen.textfieldAmount.text {
            
            if !descriptionText.isEmpty{
                description = descriptionText
            } else {
                showErrorAlert(message: "Please add description.")
                return
            }
            
            // validate amount text field input
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
            
            // create newExpense object
            let newExpense = Expense(amount: amount, description: description, category: selectedCategory, date: date, image: image)
            
            // convert to dictionary
            let newExpenseData = newExpense.toDictionary()
            
            // Post notification with both newExpense and newExpenseData. This will be processed in ExpenseLogViewController
            NotificationCenter.default.post(name: NSNotification.Name("NewExpenseAdded"), object: nil, userInfo: [
                "newExpense": newExpense,
                "newExpenseData": newExpenseData
            ])
            
            navigationController?.popViewController(animated: true)
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
    
}
