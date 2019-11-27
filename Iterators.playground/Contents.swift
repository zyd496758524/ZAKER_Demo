import UIKit

protocol iteratorProtocol {
    
    associatedtype Element
    mutating func next() -> Element?
}

struct ReverseIndexIterator: iteratorProtocol{
    
    var index: Int
    
    init<T>(array: [T]){
        index = array.endIndex - 1
    }
    
    mutating func next() -> Int? {
        
        guard index >= 0 else {
            return nil
        }
        
        defer{
            index -= 1
        }
        return index
    }
}

let letters = ["a","b","c"]

var iterator = ReverseIndexIterator(array: letters)

while let i = iterator.next() {
    print("Element \(i) of the array is \(letters[i])")
}

struct PowerIterator: iteratorProtocol {
    
    var power : NSDecimalNumber = 1
    mutating func next() -> NSDecimalNumber? {
        power = power.multiplying(by: 2)
        return power
    }
}

extension PowerIterator {
    
    mutating func find(where predicate: (NSDecimalNumber) -> Bool) -> NSDecimalNumber? {
        
        while let x = self.next(){
            if predicate(x) {
                return x
            }
        }
        return nil
    }
}

var powerIterator = PowerIterator()
var number = powerIterator.find { $0.doubleValue > 1000 }

print(number ?? "00")

struct FileLinesIterator: IteratorProtocol {
    
    let lines: [String]
    var currentLine: Int = 0

    init(filename: String) throws {
        let contents: String = try String(contentsOfFile: filename)
        lines = contents.components(separatedBy: .newlines)
    }
    
    mutating func next() -> String? {
        
        guard currentLine < lines.endIndex else {
            return nil
        }
        defer {
            currentLine += 1
        }
        return lines[currentLine]
    }
}
