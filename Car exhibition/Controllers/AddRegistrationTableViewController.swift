//
//  AddRegistrationTableViewController.swift
//  Car exhibition
//
//  Created by Наталья Шарапова on 12.01.2022.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet var brandTextField: UITextField!
    @IBOutlet var modelTextField: UITextField!
    @IBOutlet var enginePowerTextField: UITextField!
    @IBOutlet var engineTextField: UITextField!
    @IBOutlet var trunkCapacityTextField: UITextField!
    @IBOutlet weak var electricEngineSwitch: UISwitch!
    @IBOutlet weak var additionLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet weak var startOfParticipationLabel: UILabel!
    @IBOutlet weak var startOfParticipationPicker: UIDatePicker!
    @IBOutlet weak var endOfParticipationLabel: UILabel!
    @IBOutlet weak var endOfParticipationPicker: UIDatePicker!
    
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var areaStepper: UIStepper!
    @IBOutlet weak var standLabel: UILabel!
    @IBOutlet weak var standStepper: UIStepper!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - Properties
    
    var addition: Addition?
    
    var registration = Registration()
    
    let startOfParticipationLabelIndexPath = IndexPath(row: 0, section: 1)
    let endOfParticipationLabelIndexPath = IndexPath(row: 2, section: 1)
    let imageViewIndexPath = IndexPath(row: 7, section: 0)
    
    let startOfPartipicationDatePickerIndexPath = IndexPath(row: 1, section: 1)
    let endOfPartipicationDatePickerIndexPath = IndexPath(row: 3, section: 1)
    
    var isStartDatePickerShown: Bool = false {
        didSet {
            startOfParticipationPicker.isHidden = !isStartDatePickerShown
        }
    }
    var isEndDatePickerShown: Bool = false {
        didSet {
            endOfParticipationPicker.isHidden = !isEndDatePickerShown
        }
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.backgroundColor = UIColor.lightGray
        
        // Allow numberPad in 2 textFields
        enginePowerTextField.keyboardType = .numberPad
        trunkCapacityTextField.keyboardType = .numberPad
        
        // Disable saveButton
        saveButton.isEnabled = false
        
        // Assigning the data from ListOfCarsTableViewController
        updateUI()
        
        // Update Date, Location, and addition
        updateDateViews()
        updateLocation()
        updateAddition()
        
        // Set today to the datePickers
        let midnightToday = Calendar.current.startOfDay(for: Date())
        
        startOfParticipationPicker.minimumDate = midnightToday
        startOfParticipationPicker.date = midnightToday
        
        // Create tap gesture copy
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddRegistrationTableViewController.imageTapped(gesture:)))
        
        imageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Prepare the data
        switch segue.identifier {
        case "SelectAddition":
            
            let destination = segue.destination as! SelectAdditionTableViewController
            destination.delegate = self
            destination.addition = addition
            
        case "SaveSegue":
            saveRegistration()
        default:
            break
        }
    }
    
    // MARK: - Methods
    
    // Check are textFields is empty
    private func checkTextField() {
        guard let brandText = brandTextField.text, !brandText.isEmpty,
              let modelText = modelTextField.text, !modelText.isEmpty,
              let engineText = engineTextField.text, !engineText.isEmpty,
              let enginePowerText = enginePowerTextField.text, !enginePowerText.isEmpty,
              let trunckCapacityText = trunkCapacityTextField.text, !trunckCapacityText.isEmpty else {
            return
        }
        saveButton.isEnabled = true
    }
    
    func saveRegistration() {
        
        registration.startDateOfParticipation = startOfParticipationPicker.date
        registration.endDateOfParticipation = endOfParticipationPicker.date
        registration.brand = brandTextField.text ?? ""
        registration.model = modelTextField.text ?? ""
        registration.enginePower = Int(enginePowerTextField.text ?? "") ?? 0
        registration.engine = engineTextField.text ?? ""
        registration.trunkCapacity = Int(trunkCapacityTextField.text ?? "") ?? 0
        registration.numberOfArea = Int(areaStepper.value)
        registration.numberOfStand = Int(standStepper.value)
        registration.electricEngine = electricEngineSwitch.isOn
        registration.image = imageView.image
    }
    
    func updateAddition() {
        
        if let addition = addition {
            additionLabel.text = addition.name
        } else {
            additionLabel.text = "Not Set"
        }
    }
    
    func updateDateViews() {
        
        // Create the DateFormatter copy
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale.current
        
        startOfParticipationLabel.text = dateFormatter.string(from: startOfParticipationPicker.date)
        endOfParticipationLabel.text = dateFormatter.string(from: endOfParticipationPicker.date)
        
        endOfParticipationPicker.minimumDate = startOfParticipationPicker.date.addingTimeInterval(60 * 60 * 24)
    }
    
    func updateLocation() {
        
        let numberOfArea = Int(areaStepper.value)
        let numberOfStand = Int(standStepper.value)
        
        areaLabel.text = "\(numberOfArea)"
        standLabel.text = "\(numberOfStand)"
    }
    
    func updateUI() {
        
        brandTextField.text = registration.brand
        modelTextField.text = registration.model
        enginePowerTextField.text = "\(registration.enginePower)"
        engineTextField.text = registration.engine
        trunkCapacityTextField.text = "\(registration.trunkCapacity)"
        electricEngineSwitch.isOn = registration.electricEngine
        areaLabel.text = "\(registration.numberOfArea)"
        standLabel.text = "\(registration.numberOfStand)"
        imageView.image = registration.image
    }
    
    
    // MARK: - Actions
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        
        // Getting alert controller with message for choosing image sourse: camera or library
        let alertController = UIAlertController(title: "Please choose image source", message: nil, preferredStyle: .actionSheet)
        
        // Create image picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // Create cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // Add cancel action to the alertController
        alertController.addAction(cancelAction)
        
        // Check is the camera available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // Create camera action
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                
                // Choose sourse for imagePicker
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }
            
            // Add camera action to the alertController
            alertController.addAction(cameraAction)
        }
        
        // Check is the photo library available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            // Create library action
            let libraryAction = UIAlertAction(title: "Library", style: .default) { action in
                
                // Choose sourse for imagePicker
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
            
            // Add camera action to the alertController
            alertController.addAction(libraryAction)
        }
        
        // Choosing sourseView
        alertController.popoverPresentationController?.sourceView = imageView
        
        //Present alertController
        present(alertController, animated: true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateLocation()
    }
    
    @IBAction func textFieldSelected(_ sender: UITextField) {
        checkTextField()
    }
}


// MARK: - Extensions

extension AddRegistrationTableViewController /*: UITableViewDataSource */ {
    
    // Set heightForRow
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
        
        case startOfPartipicationDatePickerIndexPath:
            return isStartDatePickerShown ? UITableView.automaticDimension : 0
            
        case endOfPartipicationDatePickerIndexPath:
            return isEndDatePickerShown ? UITableView.automaticDimension : 0
            
        case imageViewIndexPath:
            return 200
            
        default:
            return UITableView.automaticDimension
        }
    }
}

extension AddRegistrationTableViewController /* UITableViewDelegate */ {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath {
        
        case startOfParticipationLabelIndexPath:
            
            isStartDatePickerShown.toggle()
            isEndDatePickerShown = false
            
        case endOfParticipationLabelIndexPath:
            
            isEndDatePickerShown.toggle()
            isStartDatePickerShown = false
            
        default:
            break
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}

extension AddRegistrationTableViewController: SelectAdditionTableViewControllerProtocol {
    
    func didSelect(addition: Addition) {
        self.addition = addition
        
        updateAddition()
    }
}

extension AddRegistrationTableViewController: UIImagePickerControllerDelegate {
    
    // Function that will be activated when the user will choose the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        
        // Paste selected image to the imageView
        imageView.image = selectedImage
        
        // Cancel imagePicker when the picture has been selected
        dismiss(animated: true)
        
    }
}

extension AddRegistrationTableViewController: UINavigationControllerDelegate {}




