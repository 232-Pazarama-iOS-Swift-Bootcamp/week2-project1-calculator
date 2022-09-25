//
//  ViewController.swift
//  iOS-Bootcamp-Hafta-2
//
//  Created by Muhammed Karakul on 24.09.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    var didOperandButtonTapped = false
    
    var result: Double = .zero {
        didSet {
            displayLabel.text = "\(result)"
        }
    }
    
    var numbers = [Double]() {
        didSet {
            print(numbers)
        }
    }
    
    var displayValue: String? {
        get {
            displayLabel.text
        }
        set {
            guard let newValue = newValue else {
                return
            }
            if displayLabel.text == "0" {
                displayLabel.text! = newValue
            } else {
                displayLabel.text! += newValue
            }
        }
    }
    
    @IBOutlet private weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func didTapDigitButton(_ sender: UIButton) {
        if didOperandButtonTapped {
            displayLabel.text = "0"
            didOperandButtonTapped = false
        }
        guard let currentTitle = sender.currentTitle else {
            return
        }
        displayValue = currentTitle
    }
    
    @IBAction private func didTapOperandButton(_ sender: UIButton) {
        didOperandButtonTapped = true
        
        guard let currentTitle = sender.currentTitle else {
            return
        }
        switch currentTitle {
        case "*":
            break
        case "/":
            break
        case "-":
            break
        case "+":
            if numbers.count > 1 {
                
                guard let firstNumber = numbers.popLast(),
                      let secondNumber = numbers.popLast() else {
                    return
                }
                
                let result = sum(firstNumber: firstNumber,
                                 secondNumber: secondNumber)
                self.result = result
            } else {
                guard let displayValueInDouble = Double(displayValue ?? "0") else {
                    return
                }
                numbers.append(displayValueInDouble)
            }
        case "=":
            guard let displayValueInDouble = Double(displayValue ?? "0") else {
                return
            }
            numbers.append(displayValueInDouble)
            
            if numbers.count > 1 {
                
                guard let firstNumber = numbers.popLast(),
                      let secondNumber = numbers.popLast() else {
                    return
                }
                
                let result = sum(firstNumber: firstNumber,
                                 secondNumber: secondNumber)
                
                //numbers.append(result)
                self.result = result
            }
            
            //displayLabel.text = "\(numbers.first ?? .zero)"
            
        default:
            break
        }
    }
    
    @IBAction private func didTapClearButton(_ sender: UIButton) {
        displayValue = "0"
    }
    
    func sum<T: Numeric>(firstNumber: T, secondNumber: T) -> T {
        firstNumber + secondNumber
    }
}

