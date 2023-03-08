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
    
    // MARK: - Reset Forms
    
    func resetSignInForm() {
        currentState = .login
        userNameField.text = ""
        passwordField.text = ""
        userNameValidationLabel.isHidden = true
        passwordValidationLabel.isHidden = true
        countryValidationLabel.isHidden = true
        countryListPicker.isHidden = true
        loginButton.isEnabled = false
        loginButton.setTitle("Login", for: .normal)
    }
    
    func resetRegisterForm() {
        currentState = .register
        userNameField.text = ""
        passwordField.text = ""
        userNameValidationLabel.isHidden = true
        passwordValidationLabel.isHidden = true
        countryValidationLabel.isHidden = true
        countryListPicker.isHidden = false
        // Load country picker
        countryList = Locale.counrtyNames(for: NSLocale(localeIdentifier: "en_US") as Locale)
        loginButton.isEnabled = false
        loginButton.setTitle("Create Account", for: .normal)
    }
    
    // MARK: - Validate Forms
    
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
    
    func navigateToSplitView() {
        let splitVC = UISplitViewController()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let masterVC = sb.instantiateViewController(withIdentifier:"MasterVC") as? UsersSplitViewontroller {
            splitVC.viewControllers = [UINavigationController(rootViewController: masterVC)]
        }
        present(splitVC, animated: true)
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
        switch currentState {
        case .login:
            // Perfrom login
            let isAuth = LoginViewModel().authenticateUser(username: userNameField.text!, password: passwordField.text!)
            if isAuth {
                // Navigate to Split view
                navigateToSplitView()
            } else {
                // Show login error
                // Create a new alert
                let errorMessage = UIAlertController(title: "Error", message: K.WarningMessage.loginErrorMsg, preferredStyle: .alert)
                // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) -> Void in
                     self?.resetSignInForm()
                  })
                 
                 //Add OK button to a dialog message
                errorMessage.addAction(ok)
                // Present alert to user
                self.present(errorMessage, animated: true, completion: nil)
            }
        case .register:
            guard let selectedCountry = selectedCountry else {
                countryValidationLabel.text = K.WarningMessage.countrySelectionMsg
                countryValidationLabel.isHidden = false
                return
            }
            // Perfrom registration
            let isRegistrationSuccess = RegistrationViewModel(username: userNameField.text!, password: passwordField.text!, country: selectedCountry).registerUser()
            if isRegistrationSuccess {
                // Navigate to Split view
                navigateToSplitView()
            } else {
                // Show Registration error
                // Create a new alert
                let errorMessage = UIAlertController(title: "Error", message: K.WarningMessage.registrationErrorMsg, preferredStyle: .alert)
                // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) -> Void in
                     self?.resetRegisterForm()
                  })
                 //Add OK button to a dialog message
                errorMessage.addAction(ok)
                // Present alert to user
                self.present(errorMessage, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - UITextField Delegates

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

// MARK: - UIPickerView Delegates

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

