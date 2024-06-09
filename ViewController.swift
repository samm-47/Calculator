import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    
    var numberOnScreen: Double = 0
    var previousNumber: Double = 0
    var performingMath = false
    var operation = 0
    var decimalAdded = false
    var memory: Double = 0
    var history: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if performingMath {
            resultLabel.text = String(sender.tag - 1)
            numberOnScreen = Double(resultLabel.text!)!
            performingMath = false
            decimalAdded = false
        } else {
            resultLabel.text = resultLabel.text! + String(sender.tag - 1)
            numberOnScreen = Double(resultLabel.text!)!
        }
    }
    
    @IBAction func operatorPressed(_ sender: UIButton) {
        if resultLabel.text != "" && sender.tag != 11 && sender.tag != 16 && sender.tag != 19 {
            previousNumber = Double(resultLabel.text!)!
            if sender.tag == 12 { // Divide
                resultLabel.text = "/"
            } else if sender.tag == 13 { // Multiply
                resultLabel.text = "x"
            } else if sender.tag == 14 { // Subtract
                resultLabel.text = "-"
            } else if sender.tag == 15 { // Add
                resultLabel.text = "+"
            } else if sender.tag == 17 { // Percentage
                resultLabel.text = "%"
            } else if sender.tag == 18 { // Square Root
                resultLabel.text = "√"
            } else if sender.tag == 20 { // Exponentiation
                resultLabel.text = "^"
            } else if sender.tag == 21 { // Logarithm
                resultLabel.text = "log"
            }
            operation = sender.tag
            performingMath = true
        } else if sender.tag == 16 { // Equals
            var result: Double = 0
            if operation == 12 {
                result = previousNumber / numberOnScreen
            } else if operation == 13 {
                result = previousNumber * numberOnScreen
            } else if operation == 14 {
                result = previousNumber - numberOnScreen
            } else if operation == 15 {
                result = previousNumber + numberOnScreen
            } else if operation == 17 {
                result = previousNumber * numberOnScreen / 100
            } else if operation == 18 {
                result = sqrt(previousNumber)
            } else if operation == 20 {
                result = pow(previousNumber, numberOnScreen)
            } else if operation == 21 {
                result = log10(numberOnScreen)
            }
            resultLabel.text = String(result)
            history += "\(previousNumber) \(resultLabel.text!) \(numberOnScreen) = \(result)\n"
            historyLabel.text = history
        } else if sender.tag == 11 { // Clear
            resultLabel.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
            decimalAdded = false
        }
    }
    
    @IBAction func decimalPressed(_ sender: UIButton) {
        if !decimalAdded {
            resultLabel.text = resultLabel.text! + "."
            decimalAdded = true
        }
    }
    
    @IBAction func toggleSignPressed(_ sender: UIButton) {
        if let currentText = resultLabel.text, let currentValue = Double(currentText) {
            resultLabel.text = String(currentValue * -1)
            numberOnScreen = Double(resultLabel.text!)!
        }
    }
    
    @IBAction func memoryPressed(_ sender: UIButton) {
        if sender.tag == 22 { // MC (Memory Clear)
            memory = 0
        } else if sender.tag == 23 { // M+ (Memory Add)
            memory += Double(resultLabel.text!)!
        } else if sender.tag == 24 { // M- (Memory Subtract)
            memory -= Double(resultLabel.text!)!
        } else if sender.tag == 25 { // MR (Memory Recall)
            resultLabel.text = String(memory)
            numberOnScreen = memory
        }
    }
}
