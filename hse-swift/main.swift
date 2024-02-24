import Foundation


let app = CalculatorApp()
app.run()

// Класс который отвечает за вычисление
class Calculator {
    var result: Double = 0
    
    func calculate(input: CalculatorInput) -> Double? { // Change return type to Double?
        switch input.operation {
        case .plus:
            result = input.firstNumber + input.secondNumber
        case .minus:
            result = input.firstNumber - input.secondNumber
        case .multiply:
            result = input.firstNumber * input.secondNumber
        case .divide:
            // Check for division by zero
            if input.secondNumber == 0 {
                print("Error: Division by zero is not allowed.")
                return nil // Indicate an error condition
            }
            result = input.firstNumber / input.secondNumber
        case .permutation:
            if input.firstNumber < input.secondNumber {
                print("Error: First number must be greater than or equal to the second number for permutations.")
                return nil // Indicate an error condition
            }
            result = permutations(n: input.firstNumber, m: input.secondNumber)
        }
        return result
    }
}


// вспомогательные функции для подсчета формулы для числа размещений из n элементов по m
func factorial(_ number: Double) -> Double {
    return number == 0 ? 1 : number * factorial(number - 1) // понять че это
}

func permutations(n: Double, m: Double) -> Double {
    return factorial(n) / factorial(n - m)
}


    
class CalculatorInputDataHelper {
    func requestInput() -> CalculatorInput? {
        let operation = requestInputOperation()
        if operation == nil { return nil }
        
        let firstNumber = requestInputFirstNumber()
        if firstNumber == nil { return nil }

        let secondNumber = requestInputSecondNumber()
        if secondNumber == nil { return nil }

        return CalculatorInput(operation: operation!, firstNumber: firstNumber!, secondNumber: secondNumber!)
    }

    func requestInputOperation() -> CalculatorOperation? {
        print("Input operation (+, -, *, /, P): ")
        let operationString = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
        if operationString?.lowercased() == "q" {
            return nil // Signal to quit
        }
        guard let operation = CalculatorOperation(rawValue: operationString!) else {
            print("Invalid operation.")
            return requestInputOperation() // Restart this method if invalid input
        }
        return operation
    }

    func requestInputFirstNumber() -> Double? {
        print("Input first number: ")
        let firstNumberString = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
        if firstNumberString?.lowercased() == "q" {
            return nil // Signal to quit
        }
        guard let firstNumber = Double(firstNumberString!) else {
            print("Invalid input for first number.")
            return requestInputFirstNumber() // Restart this method if invalid input
        }
        return firstNumber
    }

    func requestInputSecondNumber() -> Double? {
        print("Input second number: ")
        let secondNumberString = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
        if secondNumberString?.lowercased() == "q" {
            return nil // Signal to quit
        }
        guard let secondNumber = Double(secondNumberString!) else {
            print("Invalid input for second number.")
            return requestInputSecondNumber() // Restart this method if invalid input
        }
        return secondNumber
    }
}



// для хранения введеных пользователем данных можно использовать такую структуру (struct)
// вместо  -> (Double, Double, CalculatorOpertaion)? можно возврщаать просто -> CalculatorInput?
struct CalculatorInput {
    let operation: CalculatorOperation
    let firstNumber: Double
    let secondNumber: Double
}
// я не успел рассказать о структурах на лекции, но здесь все просто
// по факту это тоже самое что и class, только не надо прописывать init (он создается автоматически)
// структуры удобно использовать для хранения данных



enum CalculatorOperation: String {
    case plus = "+"
    case minus = "-"
    case multiply = "*"
    case divide = "/"
    case permutation = "P"
}


class CalculatorApp {
    let inputHelper = CalculatorInputDataHelper()
    let calculator = Calculator()

    func run() {
        print("Welcome to the Swift Calculator")
        while true {
            guard let input = inputHelper.requestInput() else {
                print("Exiting calculator.")
                break // Exit the loop if 'q' is entered
            }

            if let result = calculator.calculate(input: input) {
                print("Result: \(result)")
            } else {
                print("An error occurred. Please try again.")
            }
        }
    }
}
