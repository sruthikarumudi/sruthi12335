//
//  AddNewStudentViewController.swift
//  EducationiOS
//
//  Created by HARSHED  on 2017-07-11.
//  Copyright © 2017 LambtonIOS All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddNewProductViewController: UIViewController {
    
    @IBOutlet weak var txtprize: UITextField!
    @IBOutlet weak var txtqty: UITextField!
    @IBOutlet weak var txtcatagery: UITextField!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtid: UITextField!
    var refProduct: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        //FirebaseApp.configure()
        //getting a reference to the node artists
        refProduct = Database.database().reference().child("Products");
        
        // Do any additional setup after loading the view.
        //updateStudent()
        //deleteStudent(id: "-KomaHnqStBFhCgAE9i1")
        getProductRecords()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnInsert(_ sender: UIButton) {
        addProduct()
    }
    
    func addProduct(){
        //generating a new key inside artists node
        //and also getting the generated key
        let key = refProduct.childByAutoId().key
        
        let pid = txtid.text
        let pname =  txtname.text
        let pcat =  txtcatagery.text
        let pqty = txtqty.text
        let pprize = txtprize.text
        
        //creating artist with the given values
        let product = ["id":key,
                       "pid":pid,
                       "pname": pname,
                       "pcat": pcat,
                       "pqty": pqty,
                       "pprize":pprize
        ]
        
        //adding the artist inside the generated unique key
        refProduct.child(key).setValue(product)
        
        //displaying message
        print("Product Added")
    }
    
    func getProductRecords()
    {
        //observing the data changes
        refProduct.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //iterating through all the values
                for product in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let productObject = product.value as? [String: AnyObject]
                    let id  = productObject?["id"]
                    let pid  = productObject?["pid"]
                    let pname  = productObject?["pname"]
                    let pcat = productObject?["pcat"]
                    let pqty = productObject?["pqty"]
                    let pprize = productObject?["pprize"]
                    print("\(id) -- \(pid) -- \(pname) -- \(pcat) -- \(pqty) -- \(pprize)")
                }
                
            }
        })
    }
    
        
    @IBAction func btnLogout(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController");
            self.present(vc, animated: false, completion: nil)
        }
    }
}
