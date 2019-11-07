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
    var width = 0.0, height = 0.0
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


struct Matrix {
    let rows: Int,columns: Int
    var grid:[Double]
    // 构造方法
    init(rows: Int,columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int,column: Int) -> Bool{
        return rows >= 0 && column >= 0 && row < rows && column < columns
    }
    
    subscript (row: Int, column: Int) -> Double {
        
        get {
            assert(indexIsValid(row: row, column: column),"Index out of range")
            return grid[(row * columns) + column]
        }
        
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}


enum JZPlanet: Int {
    
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus,neptune
    
    subscript(n: Int) -> JZPlanet {
        
        return JZPlanet(rawValue: n)!
    }
}

class Vehicle {
    
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() -> Void {
        print("Verhice make noise")
    }
}

let vehicle = Vehicle()

print(vehicle.makeNoise())
print(vehicle.description)

class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 1.5

print(bicycle.description)

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentSpeed = 22.0
tandem.currentNumberOfPassengers = 2
print(tandem.description)

class Train: Vehicle {
    
    override func makeNoise() {
        super.makeNoise()
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()

class Car: Vehicle {
    final var gear = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 30
print(car.description)

class AutomaticCar: Car {
    
    override var currentSpeed: Double {
        didSet{
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0

print("AutomaticCar: \(automatic.description)")

struct Fahreheit {
    var temperature: Double = 32.0
//    init() {
//        temperature = 32.0
//    }
}

var f = Fahreheit()
print("The temperature is \(f.temperature)° Fahreheit")


struct Celsius {
    
    var temperatureInCelsius: Double
    
    init(fromFahranheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
    
}

let boilingPointOfWater = Celsius(fromFahranheit: 212.0)

print(boilingPointOfWater.temperatureInCelsius)

let freezingPointOfWater = Celsius(fromKelvin: 273.15)

print(freezingPointOfWater.temperatureInCelsius)

let bodyTemperature = Celsius(37.0)
print(bodyTemperature.temperatureInCelsius)

struct Color {
    
    let red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

class SurveyQuestion {
    
    var text: String
    var response: String?
    
    init(text: String) {
        self.text = text
    }
    
    init() {
        text = "ma ma"
    }
    
    func ask() {
        print(text)
    }
}

let oneQuestion = SurveyQuestion(text: "what can i do for you")
oneQuestion.ask()

let secondQuestion = SurveyQuestion()
secondQuestion.ask()

print(secondQuestion.response ?? "no")

// 默认构造器

//class ShoppingListItem {
//    var name: String?
//    var quantity = 1
//    var purchased: Bool = false
//}
//var item = ShoppingListItem()
//print(item.quantity)

// 结构体 逐一成员构造器

struct JSSize {
    var width = 0.0, height = 4.0
}
// 将自定义构造器 写到 扩展中，这样默认构造器、逐一成员构造器都能用来创建实例
extension JSSize{
    init(size: Size) {
        width = size.width
        height = size.height
    }
}

let oneByone = JSSize()
print(oneByone.width)

let twoByTwo = JSSize(width: 4.0, height: 4.0)
print(twoByTwo.width)

let fiveByFive = JSSize(size: Size(width: 5.0, height: 5.0))


struct JSRect {
    var origin = Point()
    var size = JSSize()
    init() {}
    
    init(origin: Point,size: JSSize) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: JSSize) {
        let originX = center.x - (size.width / 2)
        let origixY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: origixY), size: size)
    }
}

let basicRect = JSRect()
print(basicRect.origin,basicRect.size)

let originRect = JSRect(origin: Point(x: 2.0, y: 2.0),
                         size: JSSize(width: 2.0, height: 2.0))


print(originRect.origin,originRect.size)

class Food {
    
    var name: String = ""
    var description: String {
        return "my name is \(name)"
    }

    init(name: String) {
        self.name = name
    }
    // 便利构造器
    convenience init(){
        self.init(name: "Unnamed")
    }
}

let nameMeat = Food(name: "Bacon")
print(nameMeat.name)

let mysterMeat = Food()
print(mysterMeat.name)


class RectipeIngredient: Food {
    
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneItem = RectipeIngredient()
let twoItem = RectipeIngredient(name: "Bacon")
let thrItem = RectipeIngredient(name: "Eggs", quantity: 3)

class ShoppingListItem: RectipeIngredient {
    
    var purchased = false
    override var description: String{
        
        var output = "\(quantity) x \(name)"
        output += purchased ? "  √" : "  ×"
        return output
    }
}


var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 5)
]

breakfastList[0].name = "Orange Juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

let wholeNumber: Double = 12345.0

let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print(valueMaintained)
}

let valueChange = Int(exactly: pi)

if valueChange == nil {
    print("\(pi) conversion to Int does maintain value")
}

struct Animal {
    
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")

if let giraffe = someCreature {
    print(giraffe)
}

let anonymousCreature = Animal(species: "")

if anonymousCreature == nil {
 print("the anonymous creature could not be initialized")
}

/*
enum TemperatureUnit {
    
    case Kelvin, Celsius, Fahreheit
    
    init?(symbol: Character) {
        
        switch symbol {
            case "K":
                self = .Kelvin
            case "C":
                self = .Celsius
            case "F":
                self = .Fahreheit
            default:
                return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")

if fahrenheitUnit != nil {
    print("this is a defined temperature unit,so initialization succeeded")
}

let unknownUnit = TemperatureUnit(symbol: "X")

if unknownUnit == nil {
    print("this is not a defined temperature unit,so initialization failed")
}
 */

enum TemperatureUnit: Character {
    
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheit = TemperatureUnit(rawValue: "F")

if let vale = fahrenheit {
    
    print("This is a defined temperature unit, son initialzation succeeded \(vale)")
}

let unknownUnit = TemperatureUnit(rawValue: "C")

if let unit = unknownUnit {
    print(unit)
}else{
    print("initialzation failed")
}

class Product {
    let name: String
    
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class CarItem: Product {
    
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CarItem(name: "sock", quantity: 2) {
    
    print("Item:\(twoSocks.name),quantity: \(twoSocks.quantity)")
}


class Document {
    
    var name: String?
    
    init() {}
    
    init?(name: String) {
        
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class AutomaticllyNameDocument: Document {
    
    override init() {
        super.init()
        self.name = "Untitled"
    }
    
    override init(name: String){
        super.init()
        if name.isEmpty {
            self.name = "Untitled"
        }else{
            self.name = name
        }
    }
}

//class UntitledDocument: Document {
//
//    override init() {
//        super.init(name: "Untitled")
//    }
//}

class JSomeClass {
    
    required init(){
        
    }
}

class JSomeSubclass: JSomeClass {
    
    required init() {
        
    }
    
    deinit {
        
    }
}

struct Chessboard {
    
    let boardColors: [Bool] = {
        
        var tempBoard = [Bool]()
        var isBack = false
        
        for i in 1...8 {
            
            for j in 1...8 {
                
                tempBoard.append(isBack)
                isBack = !isBack
            }
            isBack = !isBack
        }
        
        return tempBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        
        return boardColors[(row * 8) + column]
    }
}


let board = Chessboard()

print(board.squareIsBlackAt(row: 1, column: 6))

print(board.squareIsBlackAt(row: 4, column: 5))
