//
//  ViewController.swift
//  Counter
//
//  Created by Kirill Kuzmin on 16.02.2025.
//

import UIKit

enum logButtonAction {
    case increment
    case decrement
    case decrimentFloreLock
    case reset
    
    var displayLogText:String {
        switch self {
        case .increment:
            return "[\(getCurrentDatetime())]: значение изменено на +1"
        case .decrement:
            return "[\(getCurrentDatetime())]: значение изменено на -1"
        case .decrimentFloreLock:
            return "[\(getCurrentDatetime())]: попытка уменьшить значение счётчика ниже 0"
        case .reset:
            return "[\(getCurrentDatetime())]: значение сброшено"
        }
        
    }
    
    func getCurrentDatetime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.string(from: Date())
    }
    
}


class ViewController: UIViewController {

    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
        
    @IBOutlet weak var actionLogTextViev: UITextView!
    
    @IBOutlet weak var counterLabel: UILabel!
    
    private var counter = 0
    private let counterDisplayText = "Значение счётчика:"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        incrementButton.tintColor = .systemRed
        resetButton.tintColor = .systemGreen
        
        actionLogTextViev.layer.borderWidth = 2
        actionLogTextViev.layer.borderColor = UIColor.systemIndigo.cgColor
        actionLogTextViev.layer.cornerRadius = 8
        actionLogTextViev.clipsToBounds = true
    }


    @IBAction func buttonDidIncrement() {
        counter += 1
        counterLabel.text = "\(counterDisplayText) \(counter)"
        
        updateLogTextViev(logType: .increment)
    }
    
    @IBAction func buttonDidDecrement() {
        if counter > 0 {
            counter -= 1
            counterLabel.text = "\(counterDisplayText) \(counter)"
            
            updateLogTextViev(logType: .decrement)
        } else {
            updateLogTextViev(logType: .decrimentFloreLock)
        }
    }
    
    
    @IBAction func buttonDidReset() {
        counter = 0
        counterLabel.text = "\(counterDisplayText) \(counter)"
        
        updateLogTextViev(logType: .reset)
    }
    
    private func updateLogTextViev(logType:logButtonAction){
        actionLogTextViev.text += "\n\(logType.displayLogText)"
        
        // Auto scroll
        let range = NSRange(location: actionLogTextViev.text.count - 1, length: 1)
        actionLogTextViev.scrollRangeToVisible(range)
    }
}

