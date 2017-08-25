//
//  ProfileVC.swift
//  smack
//
//  Created by Ricardo Herrera Petit on 8/15/17.
//  Copyright © 2017 Ricardo Herrera Petit. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    //Outlets
    
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var changeUserNameLbl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    
    }
    
     func setUpView() {
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        userEmail.text = UserDataService.instance.email
        userName.text = UserDataService.instance.name
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeUserNamePressed(_ sender: Any) {
        guard let newUsername =  changeUserNameLbl.text , changeUserNameLbl.text != "" else { return }
        let userId = UserDataService.instance.id
        
        if AuthService.instance.isLoggedIn {
            UserDataService.instance.changeUserName(userId: userId, newUsername: newUsername) { (success) in
                if(success) {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                    self.setUpView()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
      
    }
    
}
