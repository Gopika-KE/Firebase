//
//  ViewController.swift
//  GloginWithFbase
//
//  Created by macmini on 10/03/20.
//  Copyright © 2020 Makanak. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class ViewController: UIViewController ,GIDSignInDelegate{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
       GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }

    
    let arrOne = [1, 2, 3, 4, 5, 6]
    
    func binarySearch(_ inputArray: [Int], element: Int) -> Int? {
        
        var begin = 0
        var end = inputArray.count
        
        print(begin , "----begin",end , "---end")
        while begin < end {
            let mid = begin + (end - begin) / 2
             print(mid , "----mid")
            print(inputArray[mid], "----inputArray[initiall]")
            if inputArray[mid] == element {
                print(inputArray[mid], "----inputArray[mid]")
                return mid
            } else if inputArray[mid] < element {
                begin = mid
            } else {
                end = mid
            }
            
        }
        
        return nil
    }
    
   
    
    
    
    
    
    @IBAction func loginAction(_ sender: UIButton) {
        
//         GIDSignIn.sharedInstance().signIn()
        
        let val =   binarySearch([1, 2, 3, 4, 5], element: 2)
        print(val , "datata")
    }
   
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        // ...
        
        print(user , "it has everything")
        
        guard let authToken = user.authentication else {return}
        let credential = GoogleAuthProvider.credential(withIDToken: authToken.idToken,
                                                       accessToken: authToken.accessToken)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            }
             print(result?.additionalUserInfo , "results")
             print(result?.credential , "credential")
        }
            
        
        
        
        
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}

