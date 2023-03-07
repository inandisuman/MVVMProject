//
//  LoginViewController.swift
//  MVVMProject
//
//  Created by Suman Nandi on 05/03/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    var countryList = [String]()
    
    var selectedCountry: String?
    
    var currentState: UserState = .login
    
    enum UserState {
        case login
        case register
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userNameValidationLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var countryListPicker: UIPickerView!
    @IBOutlet weak var countryValidationLabel: UILabel!
    @IBOutlet weak var loginOrRegisterSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Connecting Text field
        userNameField.delegate = self
        passwordField.delegate = self
        // Connecting Picker
        countryListPicker.dataSource = self
        countryListPicker.delegate = self
        // Configure login view
        resetSignInForm()
    }
    
    /*
     Reset forms
     */
    func resetSignInForm() {
        currentState = .login
        userNameValidationLabel.isHidden = true
        passwordValidationLabel.isHidden = true
        countryValidationLabel.isHidden = true
        countryListPicker.isHidden = true
        loginButton.isEnabled = false
        loginButton.setTitle("Login", for: .normal)
    }
    
    func resetRegisterForm() {
        currentState = .register
        countryValidationLabel.isHidden = true
        countryListPicker.isHidden = false
        // Load country picker
        countryList = Locale.counrtyNames(for: NSLocale(localeIdentifier: "en_US") as Locale)
        loginButton.isEnabled = false
        loginButton.setTitle("Create Account", for: .normal)
    }
    
    /*
     Validate forms
     */
    func validateUsernameField() -> Bool {
        // Validate Username Field
        let (valid, message) = validateFormFields(userNameField)
        
        // Update Username Validation Label
        self.userNameValidationLabel.text = message
        
        // Show/Hide Username Validation Label
        UIView.animate(withDuration: 0.25, animations: {
            self.userNameValidationLabel.isHidden = valid
        })
        
        return valid
    }
    
    func validatePasswordField() -> Bool {
        // Validate Password Field
        let (valid, message) = validateFormFields(passwordField)
        
        // Update Password Validation Label
        self.passwordValidationLabel.text = message
        
        // Show/Hide Password Validation Label
        UIView.animate(withDuration: 0.25, animations: {
            self.passwordValidationLabel.isHidden = valid
        })
        
        return valid
    }
    
    func validateCountryField() -> Bool {
        let selectedRow = countryListPicker.selectedRow(inComponent: 0)
        return selectedRow >= 0
    }
    
    func validateFormFields(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, nil)
        }
        
        if textField == passwordField {
            return (text.count >= 6, K.WarningMessage.passwordRuleMsg)
        }
        
        return (text.count > 0, K.WarningMessage.usernameMissingMsg)
    }
    
    // MARK: - IBActions
    
    @IBAction func optionsDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            resetSignInForm()
        case 1:
            resetRegisterForm()
        default:
            break
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {

    }
}

// MARK: - UITextField

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userNameField:
            passwordField.becomeFirstResponder()
        case passwordField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Enable Login button if form validation successful
        loginButton.isEnabled = validateUsernameField() && validatePasswordField()
    }
}

// MARK: - UIPickerView

extension LoginViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryList.count
    }
    
    // Data for the row and component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryList[row]
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countryList[row]
        countryValidationLabel.isHidden = true
    }
}

