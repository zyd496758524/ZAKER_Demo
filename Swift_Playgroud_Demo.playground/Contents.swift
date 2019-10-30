import UIKit

var str = "Hello, playground"

print(str)

func someFunctionWithAClosure(closure:()->Void){
    
}

someFunctionWithAClosure {
    print()
}

let digitName = [0:"Zero",1:"One",2:"Two",3:"Three",4:"Four",5:"Five",6:"Six",7:"Seven",8:"Eight",9:"Nine"]

let number = [16,58,510]

let strings = number.map { (numbers) -> String in
    
    var number0 = numbers
    var output = ""
    
    repeat{
        output = digitName[number0 % 10]! + output
        number0 /= 10
        
    }while number0 > 0
    
    return output
}

print(strings)

func makeIncrementer(forIncrement amount: Int) -> () -> Int{
    
    var runningTotal = 0
    func incrementer() -> Int{
        
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

var index = makeIncrementer(forIncrement: 3)
index()

index()

var result = index()

print(result)

var completionHandlers:[() -> Void] = []

// 闭包逃逸  函数执行返回值后，再执行闭包  需用self

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void){
    
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void){
    closure()
}

class SomeClass {
    
    var x = 10
    
    func doSomething() -> Void {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        
        someFunctionWithNonescapingClosure {
            x = 200
        }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

// 自动闭包
var customersInLine = ["Chris","Alex","Ewa","Barry","Daniella"]

print(customersInLine.count)

let customerProvider = { customersInLine.remove(at: 0)}

print(customersInLine.count)

print("Now serving \(customerProvider())!")

print(customersInLine.count)


func serve(customer cunstomerProvide:() -> String){
    print("now serving \(cunstomerProvide())!")
}

serve(customer: {
    customersInLine.remove(at: 0)
})


func server(customer customerProvider: @autoclosure () -> String){
    print("Now Serving \(customerProvider())!")
}

server(customer: customersInLine.remove(at: 0))



var customerProviders:[() ->String] = []

func collectCustomerProviders(_ customerProvider:@autoclosure @escaping () -> String ){
    customerProviders.append(customerProvider)
}

collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) clousures.")

for custom in customerProviders{
   print("Now Serving \(custom())!")
}



enum Beverage: CaseIterable{
    case coffee,tea,juice
}

let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")

for beverage in Beverage.allCases {
    print(beverage)
}

enum Barcode {
    case upc(Int, Int,Int,Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
    productBarcode = .qrCode("ABCDEFGHIJKIMN")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    
    print("UPC:\(numberSystem),\(manufacturer),\(product),\(check)")
    
case .qrCode(let productCode):
    print("QR Code: \(productCode)")
}

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, netune
}

enum CompassPoint: String {
    case north, south, east, west
}

let earthOrder = Planet.earth.rawValue

let sunsetDirection = CompassPoint.west.rawValue


struct FixedLengthRnage {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRnage(firstValue: 0, length: 3)

rangeOfThreeItems.firstValue = 6

//let rangOfFourItems = FixedLengthRnage(firstValue: 0, length: 4)
//rangeOfThreeItems.firstValue = 7

class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    
    lazy var importer = DataImporter()
    
    var data = [String]()
}

let manager = DataManager()
manager.data.append("some data")
manager.data.append("some more data")

print(manager.importer.fileName)

struct Point {
    var x = 0.0
    var y = 0.0
}

struct Size {
    var width = 0.0,height = 0.0
}

struct Rect {
    
    var origin = Point()
    var size = Size()
    
    var center: Point{
        get{
            
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter){
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}


var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))

let initialSquareCenter = square.center
square.center = Point(x: 10.0, y: 10.0)

print("Square.origin is now at (\(square.origin.x),\(square.origin.y))")

struct AlternativeRect {
    
    var origin = Point()
    var size = Size()

    var center: Point {
        get{
            
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set{
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

struct CompactRect {
    
    var origin = Point()
    var size = Size()
    
    var center: Point{
        get{
            return Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        
        set{
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}


struct Cuboid {
    
    var width = 0.0,height = 0.0,depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveTwo is \(fourByFiveByTwo.volume)")

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps){
            print("将totalSteps 的值设置为 \(newTotalSteps)")
        }
        
        didSet{
            if totalSteps > oldValue {
                print("增加了\(totalSteps - oldValue)步")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 100

stepCounter.totalSteps = 200

struct SomeStructure {
    // 类 存储属性
    static var storedTypeProperty = "Some value"
    // 类 计算属性
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 2
    }
}

class SomeClassd {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 8
    }
    
    class var overrideableComputedTypeProperty: Int {
        return 45
    }
}

print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "SomeStructure"
print(SomeStructure.storedTypeProperty)

print(SomeEnumeration.computedTypeProperty)


struct AudioChannel {
    
    static let thresshouldLevel = 10
    static var maxInputLevelForAllChannels = 0
    
    var currentLevel: Int = 0 {
        didSet{
            if currentLevel > AudioChannel.thresshouldLevel {
                currentLevel = AudioChannel.thresshouldLevel
            }
            
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

class Counter {
    
    var count = 0

    func increment() -> Void {
        count += 1
    }
    
    func increment(by amount: Int) -> Void {
        count += amount
    }
    
    func reset() -> Void {
        count = 0
    }
}

var counter = Counter()
counter.increment()
print(counter.count)

counter.increment(by: 3)
print(counter.count)

counter.reset()
print(counter.count)

struct JZPoint {
    var x = 0.0,y = 0.0
    
    func isToTheRight(x: Double) -> Bool {
        return self.x > x
    }
    
    mutating func moveTo(x deltaX: Double, y deltaY: Double){
        x += deltaX
        y += deltaY
    }
}

 var somePoint = JZPoint(x: 0.0, y: 1.0)

if somePoint.isToTheRight(x: 2.0) {
    
}

somePoint.moveTo(x: 3.0, y: 5.0)
print(somePoint.x)
print(somePoint.y)

enum TriStateSwitch {
    
    case off, low, high
    mutating func next(){
        switch self {
            case .off:
                self = .low
            case .low:
                self = .high
            case .high:
                self = .off
        }
    }
}

var ovenLight = TriStateSwitch.off

ovenLight.next()
print(ovenLight)

ovenLight.next()
print(ovenLight)


class JZSomeClass {
    
    static var name = "JZSomeClass"
    
    // 类型方法
    class func someTypeMethod(){
        print(self.name)
    }
}

JZSomeClass.someTypeMethod()


struct LevelTracker {
    
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(level: Int) {
        
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level: level) {
            
            currentLevel = level
            return true
            
        }else{
            
            return false
        }
    }
}


class Player {
    
    var tracker = LevelTracker()
    let playerName: String
    
    init(name: String) {
        playerName = name
    }
    
    func compete(level: Int) -> Void {
        LevelTracker.unlock(level: level + 1)
        tracker.advance(to: level + 1)
    }
}

var player = Player(name: "Justin")
player.compete(level: 5)

print("Highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
print("\(player.tracker.currentLevel)")

struct TimesTable {
    
    let multiplier: Int
    
    subscript (index: Int) -> Int {
        return index * multiplier
    }
}

let threeTimesTable = TimesTable(multiplier: 5)
print("5 time fhree is \(threeTimesTable[8])")
