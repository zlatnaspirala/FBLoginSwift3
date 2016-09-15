//
//  ViewController.swift
//  FBLoginSwift3
//
//  Created by Nikola Lukic on 9/15/16.
//  Copyright © 2016 Nikola Lukic. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate {
    /*!
     @abstract Sent to the delegate when the button was used to logout.
     @param loginButton The button that was clicked.
     */
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }


    
     var fbLoginManager = FBSDKLoginManager();
     var loginButton = FBSDKLoginButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        
        
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        
        fbLoginManager.loginBehavior = FBSDKLoginBehavior.systemAccount
        //  fbLoginManager.loginBehavior = FBSDKLoginBehavior.web
        
        
        
        if(FBSDKAccessToken.current()==nil){
            
            print("Not Logged In..")
            
        }else{
            
            print("Logged In")
        }
        
        
        
    }

    /*
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        
        if error==nil{
            print("declined:\(result.declinedPermissions)")
            print("granted:\(result.grantedPermissions)")
            print("isCan:\(result.isCancelled)")
            print("token:\(result.token)")
            let accessToken = FBSDKAccessToken.current()
        }else{
            print(error.localizedDescription)
        }
        
    }
    */
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        
        if ((error) != nil)
        {
            //handle error
        } else {
            returnUserData()
        }
    }

    
    //////////////////////
    func returnUserData()
    {
        
        
        //  let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,interested_in,gender,birthday,email,age_range,name,picture.width(480).height(480)"])
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, friends"]  )
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("############################################ never here : \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                //         let id : NSString = result.valueForKey("id") as! String
                //  print("User ID is: \(id)")
                //etc...
            }
        })
        
        
        
        
        //#########################
        //bonus
        
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                
                
                if (error == nil){
                    print(result);
                }
                else {
                    print(error , "FUC")
                }
                
                
            })
        }
        else {
            
            print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
            //Error: Optional(Error Domain=com.facebook.sdk.core Code=8 "The operation couldn’t be completed. (com.facebook.sdk.core error 8.)"
            
        }
        
        
        
        
    }
    
    
    

    
    
}

