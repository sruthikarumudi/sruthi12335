//
//  BarcodeScanViewController.swift
//  EducationiOS
//
//  Created by HARSHED  on 2017-07-12.
//  Copyright © 2017 LambtonIOS All rights reserved.
//

import UIKit
import BarcodeScanner

class BarcodeScanViewController: UIViewController {

    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.setTitle("Scan", for: UIControlState())
        button.addTarget(self, action: #selector(buttonDidPress), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.flatGreenColorDark()
        view.addSubview(button)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        button.frame.size = CGSize(width: 250, height: 80)
        button.center = view.center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonDidPress()
    {
        let controller = BarcodeScannerController()
        controller.codeDelegate = self
        controller.errorDelegate = self
        controller.dismissalDelegate = self
        
        present(controller, animated: true, completion: nil)
    }
    
}

extension BarcodeScanViewController: BarcodeScannerCodeDelegate {
    
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        print(code)
        print(type)
        
        let delayTime = DispatchTime.now() + Double(Int64(6 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            controller.resetWithError()
        }
    }
}

extension BarcodeScanViewController: BarcodeScannerErrorDelegate {
    
    func barcodeScanner(_ controller: BarcodeScannerController, didReceiveError error: Error) {
        print(error)
    }
}

extension BarcodeScanViewController: BarcodeScannerDismissalDelegate {
    
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
