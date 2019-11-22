//
//  LoginViewController.swift
//  HikeSpot
//
//  Created by Joshua Godinez on 11/4/19.
//  Copyright © 2019 Joshua Godinez. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    var firstName = "Joshua"
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        // Do any additional setup after loading the view.
    }
    
    func setupElements(){
        //hide
        errorLabel.alpha = 0
        
        //style
        Utilities.styleText(txtFirstName)
        Utilities.styleText(txtLastName)
        Utilities.styleFilledButton(buttonLogin)
        
    }
    /*  func fireBaseRead(){
        let db = Firestore.firestore()
        db.collection("users").whereField("firstname", isEqualTo: "Analyne").getDocuments { (snapshot,error) in
                          if error != nil{
                              print(error)
                          } else{
                              for document in (snapshot?.documents)! {
                                  
                                if var name = document.data()["firstname"] as! String?{
                                    print(name)
                                    self.firstName = name
                                }
                                
                                  
                                  
                              }
                          }
                      }
    }*/
    @IBAction func loginTapped(_ sender: Any) {
        //empty text field check
        let email = txtFirstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtLastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //signing in user
        Auth.auth().signIn(withEmail: email, password: password) {(result,error) in
            if error != nil{
                //could not sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            
           
    }
       // fireBaseRead()
    
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
          if(segue.identifier == "lToHome"){
            
              if let viewController: HomeViewController = segue.destination as? HomeViewController {
                
                viewController.homeFirstName = self.firstName
                
    
                
              }
          }
      }
}
