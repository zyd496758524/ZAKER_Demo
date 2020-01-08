import UIKit

func swapTwoInt(_ a: inout Int, _ b: inout Int){
    let c = a;
    a = b;
    b = c;
}

var someInt = 3;
var anotherInt = 7;
swapTwoInt(&someInt, &anotherInt)

print("someInt is now \(someInt),and anotherInt is now \(anotherInt)");


func swapTwoValjues<T>(_ a: inout T, _ b: inout T){
    let c = a;
    a = b;
    b = c;
}


struct IntStack{
    var items = [Int]()
    mutating func push(_ item: Int){
        items.append(item)
    }
    
    mutating func pop() -> Int{
        return items.removeLast()
    }
}

struct Stack<Element>{
    
    var items = [Element]()
    
    mutating func push(_ item: Element){
        return items.append(item)
    }
    
    mutating func pop() -> Element{
        return items.removeLast()
    }
}
