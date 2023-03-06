//
//  LoginViewController.swift
//  MVVMProject
//
//  Created by Suman Nandi on 05/03/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userNameValidationField: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordValidationField: UILabel!
    @IBOutlet weak var countryListPicker: UIPickerView!
    @IBOutlet weak var countryValidation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func optionsDidChange(_ sender: UISegmentedControl) {
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
    }
    
}

