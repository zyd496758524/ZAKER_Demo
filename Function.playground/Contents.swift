import UIKit

typealias Distance = Double

// 坐标
struct Postion {
    var x: Double
    var y: Double
}

extension Postion {
    
    func within(range: Distance) -> Bool {
        return sqrt(x * x + y * y) <= range
    }
    
    func minus(_ p: Postion) -> Postion {
        return Postion(x: x - p.x, y: y - p.y)
    }
    
    var length: Double {
        return sqrt(x * x + y * y)
    }
}

// 根本问题为 判断某个点是否在某个区域内
typealias Region = (Postion) -> Bool

func circle(radius: Double) -> Region {
    
    return { point in point.length < radius}
}

func circle2(radius: Double, center: Postion) -> Region {
    return { point in point.minus(center).length <= radius}
}

func shift(_ region: @escaping Region,by offset: Postion) -> Region{
    
    return {point in region(point.minus(offset))}
}

// 原区域以外的所有点
func invert(_ region: @escaping Region) -> Region{
    return {point in !region(point)}
}

// 两个区域的交集
func intersect(_ region: @escaping Region,with other: @escaping Region) -> Region{
    return {point in region(point) && other(point)}
}
// 两个区域的并集
func union(_ region: @escaping Region, with other: @escaping Region) -> Region {
    return {point in region(point) || other(point)}
}

func subtract(_ region: @escaping Region, from original: @escaping Region) -> Region {
    return intersect(original, with: invert(region))
}


struct Ship {
    
    var postion: Postion
    // 射程
    var firingRange: Distance
    // 不安全距离
    var unsafeRange: Distance
}

extension Ship {
    
    func canEngage(ship target: Ship) -> Bool {
        
        let dx = target.postion.x - postion.x
        let dy = target.postion.y - postion.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <= firingRange
    }
    
    func canSafelyEngage(ship targer: Ship) -> Bool {
        
        let dx = targer.postion.x - postion.x
        let dy = targer.postion.y - postion.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <= firingRange && targetDistance > unsafeRange
    }
    
    func canSafelyEngage(ship target: Ship,friendly: Ship) -> Bool {
        
        let dx = target.postion.x - postion.x
        let dy = target.postion.y - postion.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        
        let friendlyDx = friendly.postion.x - postion.x
        let friendlyDy = friendly.postion.y - postion.y
        let friendlyDistance = sqrt(friendlyDx * friendlyDx + friendlyDy * friendlyDy)
        
        return targetDistance <= firingRange && targetDistance > unsafeRange && friendlyDistance > unsafeRange
    }
    
    func canSafelyEngage2(ship target: Ship,friendly: Ship) -> Bool {
        
        let targetDistance = target.postion.minus(postion).length
        let friendlyDistance = friendly.postion.minus(postion).length
        
        return targetDistance <= firingRange && targetDistance > unsafeRange && friendlyDistance > unsafeRange
    }
    
    func canSafelyEngage3(ship target: Ship, friendly: Ship) -> Bool {
        
        let rangeRegion = subtract(circle(radius: unsafeRange), from: circle(radius: firingRange))
        let firingRegion = shift(rangeRegion, by: postion)
        let friendlyRegion = shift(circle(radius: unsafeRange), by: friendly.postion)
        let resultRegion = subtract(friendlyRegion, from: firingRegion)
        return resultRegion(target.postion)
    }
}



//let shifted = shift(circle(radius: 10), by: Postion(x: 5, y: 5))
//
//var inRange = shifted(Postion(x: 4, y: 6))
//
//print(inRange)
//
//let invertRegin = invert(circle(radius: 5))
//var regined = invertRegin(Postion(x: 7, y: 10))
//
//print(regined)

