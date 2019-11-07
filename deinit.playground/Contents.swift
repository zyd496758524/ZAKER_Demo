import UIKit

class Bank {
    static var coinsInBank = 10_000
    
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receice(coins: Int){
        coinsInBank += coins
    }
}

class Player {
    
    var coinsInPurse: Int
    
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    
    deinit {
        Bank.receice(coins: coinsInPurse)
    }
}

var playone: Player? = Player(coins: 100)

print("A new player has joined the game with \(playone!.coinsInPurse) coins")

print("there are now \(Bank.coinsInBank) coins left in the bank")

playone?.win(coins: 2_000)

print("player one has \(playone!.coinsInPurse)")
print("there are now \(Bank.coinsInBank) coins left in the bank")

playone = nil
print("there are now \(Bank.coinsInBank) coins left in the bank")
