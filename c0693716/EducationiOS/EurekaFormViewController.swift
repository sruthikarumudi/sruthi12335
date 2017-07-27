//
//  EurekaFormViewController.swift
//  EducationiOS
//
//  Created by HARSHED  on 2017-07-12.
//  Copyright © 2017 LambtonIOS All rights reserved.
//

import UIKit
import Eureka
import Foundation
class EurekaFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section("Section1")
            <<< TextRow(){ row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< PhoneRow(){
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
            }
            +++ Section("Section2")
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
        }
            <<< SwitchRow("switchRowTag"){
                $0.title = "Show message"
            }
            <<< LabelRow(){
                
                $0.hidden = Condition.function(["switchRowTag"], { form in
                    return !((form.rowBy(tag: "switchRowTag") as? SwitchRow)?.value ?? false)
                })
                $0.title = "Switch is on!"
                
        }
            <<< ActionSheetRow<String>() {
                $0.title = "ActionSheetRow"
                $0.selectorTitle = "Pick a number"
                $0.options = ["One","Two","Three"]
                $0.value = "Two"    // initially selected
            }
            <<< ButtonRow("Save Data") { row in
                row.title = row.tag
                //row.presentationMode = .segueName(segueName: "NativeEventsFormNavigationControllerSegue", onDismiss:{  vc in vc.dismiss(animated: true) })
            }
            
            <<< CheckRow() {
                $0.title = "CheckRow"
                $0.value = true
            }
            
            <<< SwitchRow() {
                $0.title = "SwitchRow"
                $0.value = true
            }
            
            <<< SliderRow() {
                $0.title = "SliderRow"
                $0.value = 5.0
            }
            
            <<< StepperRow() {
                $0.title = "StepperRow"
                $0.value = 1.0
            }
            
            <<< SegmentedRow<String>(){
                $0.title = "SegmentedRow"
                $0.options = ["One", "Two"]
                }.cellSetup { cell, row in
                    cell.imageView?.image = UIImage(named: "plus_image")
            }
            
            <<< PickerInputRow<String>("Picker Input Row"){
                $0.title = "Options"
                $0.options = []
                for i in 1...10{
                    $0.options.append("option \(i)")
                }
                $0.value = $0.options.first
            }
        
            +++ SelectableSection<ListCheckRow<String>>("Where do you live", selectionType: .singleSelection(enableDeselection: true))
        
        let continents = ["Africa", "Antarctica", "Asia", "Australia", "Europe", "North America", "South America"]
        for option in continents
        {
            form.last! <<< ListCheckRow<String>(option)
            { listRow in
                listRow.title = option
                listRow.selectableValue = option
                listRow.value = nil
            }
        }
       
    }

}
