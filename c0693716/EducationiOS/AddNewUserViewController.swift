//
//  AddNewUserViewController.swift
//  EducationiOS
//
//  Created by HARSHED on 2017-07-25.
//  Copyright © 2017 MoxDroid. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class AddNewUserViewController: UIViewController {

    
    @IBOutlet weak var txtid: UITextField!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var txtphone: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    var refUser: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        //FirebaseApp.configure()
        //getting a reference to the node artists
        refUser = Database.database().reference().child("Users");
        
        // Do any additional setup after loading the view.
        //updateStudent()
        //deleteStudent(id: "-KomaHnqStBFhCgAE9i1")
        getUserRecords()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnInsert(_ sender: Any) {
        addUser()
    }
    func addUser(){
        //generating a new key inside artists node
        //and also getting the generated key
        let key = refUser.childByAutoId().key
        
        let uid = txtid.text
        let uname =  txtname.text
        let upassword =  txtpassword.text
        let uphone = txtphone.text
        let uemail = txtemail.text
        
        //creating artist with the given values
        let user = ["id":key,
                       "uid":uid,
                       "uname": uname,
                       "upassword": upassword,
                       "uphone": uphone,
                       "uemail":uemail
        ]
        
        //adding the artist inside the generated unique key
        refUser.child(key).setValue(user)
        
        //displaying message
        print("User Added")
    }
    
    func getUserRecords()
    {
        //observing the data changes
        refUser.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //iterating through all the values
                for user in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let userObject = user.value as? [String: AnyObject]
                    let id  = userObject?["id"]
                    let uid  = userObject?["uid"]
                    let uname  = userObject?["uname"]
                    let upassword = userObject?["upassword"]
                    let uphone = userObject?["uphone"]
                    let uemail = userObject?["uemail"]
                    print("\(id) -- \(uid) -- \(uname) -- \(upassword) -- \(uphone) -- \(uemail)")
                }
                
            }
        })
    }

    
    @IBAction func btnLogout(_ sender: Any) {
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController");
            self.present(vc, animated: false, completion: nil)
        }
    }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


