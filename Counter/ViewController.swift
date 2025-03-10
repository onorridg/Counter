//
//  ViewController.swift
//  Counter
//
//  Created by Kirill Kuzmin on 16.02.2025.
//

import UIKit

enum LogButtonAction {
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


final class ViewController: UIViewController {

    @IBOutlet weak private var incrementButton: UIButton!
    @IBOutlet weak private var resetButton: UIButton!
            
    @IBOutlet weak private var actionLogTextView: UITextView!
    
    @IBOutlet weak private var counterLabel: UILabel!
    
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


    @IBAction private func buttonDidIncrement() {
        counter += 1
        counterLabel.text = "\(counterDisplayText) \(counter)"
        
        updateActionLogTextView(logType: .increment)
    }
    
    @IBAction private func buttonDidDecrement() {
        if counter > 0 {
            counter -= 1
            counterLabel.text = "\(counterDisplayText) \(counter)"
            
            updateActionLogTextView(logType: .decrement)
        } else {
            updateActionLogTextView(logType: .decrimentFloreLock)
        }
    }
    
    
    @IBAction private func buttonDidReset() {
        counter = 0
        counterLabel.text = "\(counterDisplayText) \(counter)"
        
        updateActionLogTextView(logType: .reset)
    }
    
    private func updateActionLogTextView(logType:LogButtonAction){
        actionLogTextView.text += "\n\(logType.displayLogText)"
        
        // Auto scroll
        let range = NSRange(location: actionLogTextView.text.count - 1, length: 1)
        actionLogTextView.scrollRangeToVisible(range)
    }
}

