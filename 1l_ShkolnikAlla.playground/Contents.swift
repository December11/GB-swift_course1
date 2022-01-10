import Foundation

//1. Решить квадратное уравнение.
//Добавила вывод в консоль значения корней
let a = Double.random(in: 1...5).rounded()
let b = Double.random(in: 0...10).rounded()
let c = Double.random(in: -10...10).rounded()

let d =  pow(b, 2) - 4 * a * c

if d > 0 {
    let x1 = (-b + sqrt(d)) / 2 * a
    let x2 = (-b - sqrt(d)) / 2 * a
    print("1. Первый корень = \(round(x1 * 100)/100), Второй = \(round(x2 * 100)/100)")
}
else if d == 0 {
    let x1 = -b / 2 * a
    print("1. Корень уравнения = \(round(x1 * 100)/100)")
}
else {
    print("1. Уравнение не имеет корней")
}

//2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
let cathetus1 = Double.random(in: 1...5).rounded()
let cathetus2 = Double.random(in: 0...10).rounded()
let hypotenuse = sqrt(pow(cathetus1, 2) + pow(cathetus2, 2))
let area = (cathetus1 * cathetus2) / 2
let perimeter = cathetus1 + cathetus2 + hypotenuse
print("2. Гипотенуза: c = \(round(hypotenuse * 10)/10), Площадь = \((round(area * 10)/10)), Периметр = \((round(perimeter * 10)/10))")

//3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
let userSum = 100000.00
let userPercent = 8.5
var totalBalance = 0.0
let period = 5
for _ in 1...period {
    totalBalance = ((userSum + totalBalance) * (1 + (userPercent / 100))) - userSum
}

print("3. Сумма вклада: \(userSum), годовой процент: \(userPercent). За 5 лет доход с капитализацией составит: \(round((userSum + totalBalance) * 100) / 100)")
