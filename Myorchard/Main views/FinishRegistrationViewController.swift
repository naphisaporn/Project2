//
//  FinishRegistrationViewController.swift
//  Myorchard
//
//  Created by PewPew on 6/2/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit
import JGProgressHUD

class FinishRegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var doneButtonOutlet: UIButton!
    
    //MARK: - Vars
    let hud = JGProgressHUD(style: .dark)
    

    //MARK: - View Lifecycle
       override func viewDidLoad() {
           super.viewDidLoad()

           
           nameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
           surnameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
           addressTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
       }
    
    //MARK: - IBActions
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        finishiOnboarding()
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
            
            self.dismiss(animated: true, completion: nil)
        }
        
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            
            updateDoneButtonStatus()
        }
    
    //MARK: - Helper
    private func updateDoneButtonStatus() {
        
        if nameTextField.text != "" && surnameTextField.text != "" && addressTextField.text != "" {
            
            doneButtonOutlet.backgroundColor =  #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            doneButtonOutlet.isEnabled = true
        } else {
            doneButtonOutlet.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            doneButtonOutlet.isEnabled = false

        }
        
        
    }
    private func finishiOnboarding() {
        
        let withValues = [kFIRSTNAME : nameTextField.text!, kLASTNAME : surnameTextField.text!, kONBOARD : true, kFULLADDRESS : addressTextField.text!, kFULLNAME : (nameTextField.text! + " " + surnameTextField.text!)] as [String : Any]
        
        
        updateCurrentUserInFirestore(withValues: withValues) { (error) in
            
            if error == nil {
                self.hud.textLabel.text = "Updated!"
                self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)

                self.dismiss(animated: true, completion: nil)
            } else {
                
                print("error updating user \(error!.localizedDescription)")
                
                self.hud.textLabel.text = error!.localizedDescription
                self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)
            }
        }
    }



    }


