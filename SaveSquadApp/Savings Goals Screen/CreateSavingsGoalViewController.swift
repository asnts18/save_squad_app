//
//  CreateSavingsGoalViewController.swift
//  SaveSquadApp
//
//  Created by Bubesh Dev on 11/7/24.
//
import UIKit
import PhotosUI

// Protocol to pass the created goal back to the main view controller
protocol CreateSavingsGoalDelegate: AnyObject {
    func didCreateGoal(_ goal: SavingsGoal)
}

class CreateSavingsGoalViewController: UIViewController, PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let createSavingsGoalView = CreateSavingsGoalView()
    weak var delegate: CreateSavingsGoalDelegate?

    override func loadView() {
        view = createSavingsGoalView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSavingsGoalView.addPhotoButton.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        createSavingsGoalView.createGoalButton.addTarget(self, action: #selector(createGoal), for: .touchUpInside)
        createSavingsGoalView.cancelButton.addTarget(self, action: #selector(cancelCreation), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    // MARK: - Select Photo
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
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            createSavingsGoalView.goalImageView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    // MARK: - PHPickerViewControllerDelegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let result = results.first {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.createSavingsGoalView.goalImageView.image = image
                    }
                }
            }
        }
    }

    
    // MARK: - Create Goal
    @objc func createGoal() {
        guard let name = createSavingsGoalView.nameTextField.text, !name.isEmpty,
              let description = createSavingsGoalView.descriptionTextField.text, !description.isEmpty,
              let costText = createSavingsGoalView.amountTextField.text, let cost = Double(costText),
              let image = createSavingsGoalView.goalImageView.image else {
            // Show alert if any required field is missing
            let alert = UIAlertController(title: "Error", message: "Please fill all fields and select an image.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let targetDate = createSavingsGoalView.targetDatePicker.date
        
        // Create the SavingsGoal object
        let newGoal = SavingsGoal(name: name, description: description, cost: cost, targetDate: targetDate, image: image)
        
        // Use the delegate to pass back the created goal
        delegate?.didCreateGoal(newGoal)
        
        // Dismiss the view controller
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Cancel Creation
    @objc func cancelCreation() {
        navigationController?.popViewController(animated: true)
    }
}

