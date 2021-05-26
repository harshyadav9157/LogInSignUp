//
//  TableViewController.swift
//  UIlogin
//
//  Created by harsh yadav on 04/03/21.
//

import UIKit
import GoogleSignIn
import Firebase

class TableViewController: UITableViewController {
    
    @IBOutlet weak var txtEmailid: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleSignIn()
    }
    
    
    //MARK: - Google Sign Function
    
    func googleSignIn(){
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        if ((GIDSignIn.sharedInstance()?.hasPreviousSignIn()) != nil){
            print("already Login")
        }
    }
    
    //MARK: - Login Button Function
    
    func loginButton(){
        if let email = txtEmailid.text , let password = txtpassword.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.openAlert(title: "Alert", message: "Please Enter Valid  Email address and password  ", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in print("Okay clicked!")}])
                    print(e)
                }else{
                    let newformVc = self.storyboard?.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
                    self.navigationController?.pushViewController(newformVc, animated: true)
                }
            }
        }
    }
    
    
        //MARK: - Sign Up Button Tapped
    
    @IBAction func buttonsignUpclicked(_ sender: UIButton) {
        let signupVc = self.storyboard?.instantiateViewController(identifier: "signUpTableViewController") as! signUpTableViewController
        self.navigationController?.pushViewController(signupVc, animated: true)
        
    }
    
    // MARK: - Google Button Press
    
    @IBAction func googleButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
        
        
    }
    
    // MARK: - login button pressed condition and open alerts.
    
    @IBAction func loginClicked(_ sender: UIButton) {
        
        if let email = txtEmailid.text, let password = txtpassword.text{
            if !email.validateEmailId(){
                openAlert(title: "Alert", message: "Email address not found.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in print("Okay clicked!")}])
            }else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Please Enter valid password.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in print("Okay clicked!")}])
            }else{
                loginButton()
            }
        }else{
            openAlert(title: "Alert", message: "Please add detail.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in print("Okay clicked!")}])
        }
    }
}

// MARK: - EXTENSION which contatain google sign in delegate method.

extension TableViewController : GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil) {
            print("all good")
        }else{
            
            let newformVc = self.storyboard?.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
            self.navigationController?.pushViewController(newformVc, animated: true)
            print("\(user.profile.email ?? "No Name")")
            
            // here we write a code for navigation.
        }
       
    }
    
    
}

