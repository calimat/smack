//
//  UserDataService.swift
//  smack
//
//  Created by Ricardo Herrera Petit on 8/10/17.
//  Copyright © 2017 Ricardo Herrera Petit. All rights reserved.
//
import Alamofire
import Foundation

class UserDataService {
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id:String, color:String, avatarName:String, email:String, name:String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName:String) {
        self.avatarName = avatarName
    }
    
    func setUserName(userName:String) {
        self.name = userName
    }
    
    func returnUIColor(components: String) -> UIColor {
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma =  CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r , g ,b, a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else {return defaultColor}
        guard let gUnwrapped = g else {return defaultColor}
        guard let bUnwrapped = b else {return defaultColor}
        guard let aUnwrapped = a else {return defaultColor}
        
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColor
    
    }
    
    func changeUserName(userId: String, newUsername: String, completion: @escaping CompletionHandler) {
        
        let user = UserDataService.instance
       
        
        let body: [String: Any] = [
            "name": newUsername,
            "email":user.email,
            "avatarName": user.avatarName,
            "avatarColor": user.avatarColor
        ]
        
        
        
        Alamofire.request("\(URL_CHANGE_USERNAME)\(userId)", method: .put, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseString { (response) in
            
            if response.result.error == nil {
              
                self.setUserData(id: user.id, color: user.avatarColor, avatarName: user.avatarName, email: user.email, name: newUsername)
                
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
    
    
}
