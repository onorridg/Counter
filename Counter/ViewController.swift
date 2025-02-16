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
            
    @IBOutlet weak var actionLogTextView: UITextView!
    
    @IBOutlet weak var counterLabel: UILabel!
    
    private var counter = 0
    private let counterDisplayText = "Значение счётчика:"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        incrementButton.tintColor = .systemRed
        resetButton.tintColor = .systemGreen
        
        actionLogTextView.layer.borderWidth = 2
        actionLogTextView.layer.borderColor = UIColor.systemIndigo.cgColor
        actionLogTextView.layer.cornerRadius = 8
        actionLogTextView.clipsToBounds = true
    }


    @IBAction func buttonDidIncrement() {
        counter += 1
        counterLabel.text = "\(counterDisplayText) \(counter)"
        
        updateActionLogTextView(logType: .increment)
    }
    
    @IBAction func buttonDidDecrement() {
        if counter > 0 {
            counter -= 1
            counterLabel.text = "\(counterDisplayText) \(counter)"
            
            updateActionLogTextView(logType: .decrement)
        } else {
            updateActionLogTextView(logType: .decrimentFloreLock)
        }
    }
    
    
    @IBAction func buttonDidReset() {
        counter = 0
        counterLabel.text = "\(counterDisplayText) \(counter)"
        
        updateActionLogTextView(logType: .reset)
    }
    
    private func updateActionLogTextView(logType:logButtonAction){
        actionLogTextView.text += "\n\(logType.displayLogText)"
        
        // Auto scroll
        let range = NSRange(location: actionLogTextView.text.count - 1, length: 1)
        actionLogTextView.scrollRangeToVisible(range)
    }
}

