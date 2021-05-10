import Foundation

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
struct Queue<T: Comparable> {
    var elements = [T]()
    var count: Int {
        var temp = elements
        var qnt = 0
        while !temp.isEmpty {
            qnt += 1
            temp.removeFirst()
        }
        return qnt
    }

    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    mutating func dequeue() -> T? {
        return elements.removeFirst()
    }
    mutating func sortAscending() -> [T] {
        return elements.sorted {$0 > $1}
    }
    mutating func sortDescending() -> [T] {
        return elements.sorted {$0 < $1}
    }
    subscript(index: Int) -> T? {
        if index >= elements.count || index < 0 {
            return nil
        } else {
            return elements[index]
        }
    }
    
    func description(index: Int) {
        if let elem = a1[index] {
            print("* \(index)й элемент в очереди - \(elem)")
        } else {
            print("* В очереди нет элемента с таким индексом")
        }
    }
}

//Расширение просто для практики
extension Queue {
    func isEvenIndex(index: Int) -> Bool { index % 2 == 0 }
    func isOddIndex(index: Int) -> Bool { index % 2 != 0 }
    func isEqual(item: T, at index: Int) -> Bool { elements[index] == item }
    func isNotEqual(item: T, at index: Int) -> Bool { elements[index] != item }
    
    func filter(function: (Int) -> Bool) -> [T] {
        var tmp = [T]()
        for i in 0...elements.count-1 {
            if function(i) {
                tmp.append(elements[i])
            }
        }
        return tmp
    }
    
    func filter(item: T, function: (T, Int) -> Bool) -> [T] {
        var tmp = [T]()
        for i in 0...elements.count-1 {
            if function(item, i) {
                tmp.append(elements[i])
            }
        }
        return tmp
    }
}

var a1 = Queue<Int>()
var randLen = Int.random(in: 0...20)
for _ in 0...randLen {
    let rand = Int.random(in: 0...1000)
    a1.enqueue(rand)
}

a1.count
print(a1)
print("qnt = \(a1.count)")

a1.description(index: 3)
a1.description(index: 24)

var a2 = a1.filter(function: a1.isEvenIndex)
print(a2)
