//
//  signUpTableViewController.swift
//  UIlogin
//
//  Created by harsh yadav on 05/03/21.
//

import UIKit
import Firebase

class signUpTableViewController: UITableViewController {
    
    
    // MARK:- IBOulets
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        myImage.isUserInteractionEnabled = true
        myImage.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func imageTapped(tapGestureRecognizer : UITapGestureRecognizer){
        opengallery()
    }
    
    // MARK: - Login button Pressed
    @IBAction func buttonloginclicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var myImage: UIImageView!
    
    // MARK: - SignUp Button Pressed
    @IBAction func buttonSignUpClicked(_ sender: UIButton) {
        let imgSystem = UIImage(systemName: "plus.message")
        
        if myImage.image?.pngData() != imgSystem?.pngData(){
            // profile image selected
            if let email = txtEmail.text, let password = txtPass.text, let username = txtUserName.text, let conPassword = txtConfirmPass.text{
                if username == ""{
                    print("Please enter username")
                }else if !email.validateEmailId(){
                    openAlert(title: "Alert", message: "Please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    print("email is not valid")
                }else if !password.validatePassword(){
                    openAlert(title: "Alert", message: "Password is not valid , Minimum 8 characters at least 1 Alphabet and 1 Number", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    print("Password is not valid")
                } else{
                    if conPassword == ""{
                        openAlert(title: "Alert", message: "Please confirm password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                        print("Please confirm password")
                    }else{
                        if password == conPassword{
                            // navigation code
                            ButtonsignUppressed()
                            print("Navigation code Yeah!")
                        }else{
                            openAlert(title: "Alert", message: "password does not match", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                            print("password does not match")
                        }
                    }
                }
            }else{
                print("Please check your details")
            }
        }else{
            print("Please select profile picture")
            openAlert(title: "Alert", message: "Please select profile picture", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        }
        
    }
    
    
    // MARK: - Authenitication check for email and passowd
    func ButtonsignUppressed(){
        if  let pass = txtPass.text , let emailId = txtEmail.text{
            Auth.auth().createUser(withEmail: emailId , password: pass) { authResult, error in
                if let e = error{
                    print(e)
                }else{
                    let newformVc = self.storyboard?.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
                    self.navigationController?.pushViewController(newformVc, animated: true)
                }
            }
            
        }
    }
    
}

// MARK: - Delegate Methods for image.

extension signUpTableViewController : UINavigationControllerDelegate , UIImagePickerControllerDelegate{
    
    func opengallery(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            present(picker , animated: true)
        }
    }
    // to add image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            myImage.image = img
        }
        dismiss(animated: true)
    }
}
