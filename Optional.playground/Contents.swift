import UIKit
// 房间
class Room {
    
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
     
        if buildingName != nil {
            
            return buildingName
            
        }else if let buildingNumber = buildingNumber, let street = street {
            
            return "\(buildingNumber) \(street)"
        }else {
            return nil
        }
    }
}

// 住宅
class Residence {
    // room 数组
    var rooms = [Room]()
    // 计算型属性 房间个数
    var numberOfRooms: Int {
        return rooms.count
    }
    
    // 下标
    subscript (index: Int) -> Room {
        
        get{
            return rooms[index]
        }
        set{
            
            rooms[index] = newValue
        }
    }
    
    func printNumberOfRoom() {
        print("The number of rooms is \(numberOfRooms)")
    }
    // 地址
    var address: Address?
}

// 人
class Person {
    var residence: Residence?
}

let john = Person()

//let roomCount = john.residence!.numberOfRooms
/*
if let roomCount = john.residence?.numberOfRooms {
    
    print("John's residence has \(roomCount) rooms")
}else{
    print("Unable to retrieve the number of room")
}
*/

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room")
}else {
    print("Unable to retrieve the number of rooms.")
}

let someAddress = Address()

someAddress.buildingNumber = "28"
someAddress.street = "Acacia Road"

john.residence?.address = someAddress

print(john.residence?.address?.buildingIdentifier() ?? "0")

func createAddress() -> Address {
    
    print("Functions was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "asbdc"
    return someAddress
}

john.residence?.address = createAddress()
