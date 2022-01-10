import Foundation

//1. Написать функцию, которая определяет, четное число или нет.
func isEven(number: Int) -> Bool {
    if number % 2 == 0 {
        return true
    } else {
        return false
    }
}

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func isNotDivTo3(number: Int) -> Bool {
    if number % 3 != 0 {
        return true
    } else {
        return false
    }
}

//3. Создать возрастающий массив из 100 чисел.
func generateAscendingArray(length: Int) -> [Int] {
    var array = [Int]()
    for i in 0...length - 1 {
        array.append(i + 1)
    }
    return array
}

var array1 = generateAscendingArray(length: 100)
print("3. Создать возрастающий массив из 100 чисел:\n\(array1)")

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
var i = 0
while (i < array1.count) {
    if isEven(number: array1[i]) || isNotDivTo3(number: array1[i]) {
        array1.remove(at: i)
    } else {
        i += 1
    }
}
print("\n4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3:\n\(array1)")

//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.
//5.1 - Решение с помощью рекурсивной функции
//Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.
var arrayFibonacci: [UInt] = []
func getFibonacciArray (array:inout [UInt], max: Int) {
    for i in 0 ... max {
        switch (array.count) {
        case 0:
            array.append(0)
        case 1:
            array.append(1)
        default:
            array.append(array[i-1] + array[i-2])
        }
    }
}
getFibonacciArray(array: &arrayFibonacci, max: 50)
print ("\n5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.\n\(arrayFibonacci)")

//6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
//
//a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
//b. Пусть переменная p изначально равна двум — первому простому числу.
//c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
//d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
//e. Повторять шаги c и d, пока возможно.

let max = 100
var primeNumbersArray = [Int]()
var p = 2
for i in 2..<max {
    primeNumbersArray.append(i)
}
func removeNotPrimeNumbers(array:inout [Int], p: Int) {
    var i = p
    while (i < array.count) {
        if array[i] % p == 0 {
            array.remove(at: i)
        } else {
            i += 1
        }
    }
}
i = 0
while i < primeNumbersArray.count - 1  {
    removeNotPrimeNumbers(array: &primeNumbersArray, p: primeNumbersArray[i])
    i += 1
}
print("\n6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена.\n\(primeNumbersArray)")
