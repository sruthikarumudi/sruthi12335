//
//  OrderViewController.swift
//  EducationiOS
//
//  Created by HARSHED on 2017-07-25.
//  Copyright © 2017 MoxDroid. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class OrderViewController: UIViewController {

    @IBOutlet weak var txtid: UITextField!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txttype: UITextField!
    @IBOutlet weak var txtdate: UITextField!
    @IBOutlet weak var txtaddress: UITextField!
    var refOrder: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        //FirebaseApp.configure()
        //getting a reference to the node artists
        refOrder = Database.database().reference().child("Orders");
        
        // Do any additional setup after loading the view.
        //updateStudent()
        //deleteStudent(id: "-KomaHnqStBFhCgAE9i1")
        getOrderRecords()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnSubmitOrder(_ sender: Any) {
        addOrder()
    }

    func addOrder(){
        //generating a new key inside artists node
        //and also getting the generated key
        let key = refOrder.childByAutoId().key
        
        let oid = txtid.text
        let oname =  txtname.text
        let otype =  txttype.text
        let odate = txtdate.text
        let oaddress = txtaddress.text
        
        //creating artist with the given values
        let order = ["id":key,
                    "oid":oid,
                    "oname": oname,
                    "otype": otype,
                    "odate": odate,
                    "oaddress":oaddress
        ]
        
        //adding the artist inside the generated unique key
        refOrder.child(key).setValue(order)
        
        //displaying message
        print("Order Added")
    }
    
    func getOrderRecords()
    {
        //observing the data changes
        refOrder.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //iterating through all the values
                for order in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let orderObject = order.value as? [String: AnyObject]
                    let id  = orderObject?["id"]
                    let oid  = orderObject?["oid"]
                    let oname  = orderObject?["oname"]
                    let otype = orderObject?["otype"]
                    let odate = orderObject?["odate"]
                    let oaddress = orderObject?["oaddress"]
                    print("\(id) -- \(oid) -- \(oname) -- \(otype) -- \(odate) -- \(oaddress)")
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


