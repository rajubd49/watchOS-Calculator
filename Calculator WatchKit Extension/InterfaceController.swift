//
//  InterfaceController.swift
//  Calculator WatchKit Extension
//
//  Created by Raju on 8/31/18.
//  Copyright © 2018 Raju. All rights reserved.
//

import WatchKit
import Foundation

enum modes {
    case NOT_SET
    case ADDITION
    case SUBTRACTION
}

class InterfaceController: WKInterfaceController {

    var valueString: String = "0"
    var currentMode:modes = modes.NOT_SET
    var savedNumber:Int64 = 0
    var lastButtonWasMode: Bool = false
    
    @IBOutlet var valueLabel: WKInterfaceLabel!
    @IBAction func tapped0() {tappedNumber(number: 0)}
    @IBAction func tapped1() {tappedNumber(number: 1)}
    @IBAction func tapped2() {tappedNumber(number: 2)}
    @IBAction func tapped3() {tappedNumber(number: 3)}
    @IBAction func tapped4() {tappedNumber(number: 4)}
    @IBAction func tapped5() {tappedNumber(number: 5)}
    @IBAction func tapped6() {tappedNumber(number: 6)}
    @IBAction func tapped7() {tappedNumber(number: 7)}
    @IBAction func tapped8() {tappedNumber(number: 8)}
    @IBAction func tapped9() {tappedNumber(number: 9)}

    func tappedNumber(number:Int) {
        if lastButtonWasMode {
            lastButtonWasMode = false
            valueString = "0"
        }
        valueString = valueString + ("\(number)")
        updateValue()
    }
    
    func updateValue() {
        guard let valueInt:Int64 = Int64(valueString) else {
            valueLabel.setText("Number is too long")
            return
        }
        savedNumber = (currentMode == modes.NOT_SET) ? valueInt : savedNumber
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let num = NSNumber(integerLiteral: Int(valueInt))
        let numberString = numberFormatter.string(from: num)
        valueLabel.setText(numberString)
    }
    
    @IBAction func tappedPlus() {
        changeMode(newMode: modes.ADDITION)
    }
    
    @IBAction func tappedMinus() {
        changeMode(newMode: modes.SUBTRACTION)
    }
    
    func changeMode(newMode:modes) {
        if savedNumber == 0 {
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
    }
    
    @IBAction func tappedClear() {
        savedNumber = 0
        valueString = "0"
        valueLabel.setText("0")
        currentMode = modes.NOT_SET
        lastButtonWasMode = false
    }
    
    @IBAction func tappedEqual() {
        guard let number:Int64 = Int64(valueString) else {
            return
        }
        if currentMode == modes.NOT_SET || lastButtonWasMode {
            return
        }
        
        if currentMode == modes.ADDITION {
            savedNumber += number
        }
        else if currentMode == modes.SUBTRACTION {
            savedNumber -= number
        }
        currentMode = modes.NOT_SET
        valueString = "\(savedNumber)"
        updateValue()
        lastButtonWasMode = true
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
