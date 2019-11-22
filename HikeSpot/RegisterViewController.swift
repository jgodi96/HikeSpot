//
//  RegisterViewController.swift
//  HikeSpot
//
//  Created by Joshua Godinez on 11/4/19.
//  Copyright © 2019 Joshua Godinez. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtLast: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        // Do any additional setup after loading the view.
    }
    func setUpElements(){
            //hide error
        lblError.alpha = 0
        //style 
        Utilities.styleText(txtFirst)
        Utilities.styleText(txtLast)
        Utilities.styleText(txtEmail)
        Utilities.styleText(txtPassword)
        Utilities.styleFilledButton(signUpButton)
        
    }
    //check fields
    func validate()->String?{
        //check all fields filled
        if txtFirst.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           txtLast.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        
            return "Fill in all text fields"
        }
        
        
        return nil
    }
    func showError(_ message:String){
        lblError.text = message
        lblError.alpha = 1
    }
  
    @IBAction func signUpTapped(_ sender: Any) {
        //validation
        let error = validate()
        if error != nil {
            //fields not filled
            showError(error!)
        }
        else
        {//strip out white spaces
            let firstName = txtFirst.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = txtLast.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //create user
            
            
            Auth.auth().createUser(withEmail: email, password: password) { (result,err) in
               
                if err != nil {
                    //error creating user
                    self.showError("Error creating user")
                }
                else{
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid]){ (error) in
                       
                        if error != nil {
                            self.showError("There was an error when trying to create user data")
                        }
                    }
                
                }
                
            }
        
        //create user
        
     }
   
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             
             
             
             if(segue.identifier == "toDetail"){
                 if let viewController: HomeViewController = segue.destination as? HomeViewController {
                
       
                   
                 }
             }
         }

}
