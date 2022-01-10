enum NewActionsType {
    case loadCargo(cargo: Int)
    case releaseCargo(cargo: Int)
    case openHatch
    case closeHatch
    case toggleHatch
 }

enum WindowActions {
    case openWindow
    case closeWindow
    case toggleWindow
}

enum EngineActions {
    case startEngine
    case stopEngine
    case toggleEngine
}

//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
protocol CarDrivable {
    var brand: String {get}
    var model: String {get}
    var productionYear: Int {get}
    var mileage: Double {get}
    var fuelLevelPercent: Int {get}
    var isWindowOpened: Bool {get}
    var isEngineStarted: Bool {get}
    
    func action(_ action: NewActionsType)
    func status() -> String
    
}

//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
extension CarDrivable {
    func action(_ action: WindowActions) {
    }
    
    func action(_ action: EngineActions) {
    }
}

//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
extension SportCar: CustomStringConvertible {
    var description: String {
        return """
        \n* вывожу описание
        Бренд: \(brand)
        Модель: \(model)
        Год выпуска: \(productionYear)г.
        Пробег: \(mileage)км
        Максимальная скорость: \(topSpeed)км/ч
        Время разгона до 100км/ч: \(accelerationTo100Time)с
        """
    }
}

extension TruckCar: CustomStringConvertible {
    var description: String {
        return """
        \n* вывожу описание
        Бренд: \(brand)
        Модель: \(model)
        Год выпуска: \(productionYear)г
        Пробег: \(mileage)км
        Тип кузова: \(bodyType.rawValue)
        Грузоподъемность: \(truckCapacity)кг
        """
    }
}

class SportCar: CarDrivable {
    let brand: String
    let model: String
    let productionYear: Int
    var mileage: Double = 0.0
    var fuelLevelPercent: Int = 100
    let topSpeed: Int
    let accelerationTo100Time: Int
    var isWindowOpened: Bool = false
    var isEngineStarted: Bool = false
    var isHatchOpened: Bool = false
    
    init(brand: String, model: String, productionYear: Int, fuelLevel: Int, topSpeed: Int, accelerationTo100Time: Int) {
        self.brand = brand
        self.model = model
        self.productionYear = productionYear
        self.fuelLevelPercent = fuelLevel
        self.topSpeed = topSpeed
        self.accelerationTo100Time = accelerationTo100Time
        
        print("\n* создаю новый объект \(brand) \(model) ")
        if fuelLevelPercent > 100 {
            print("* значение \(fuelLevelPercent) > 100")
            self.fuelLevelPercent = 100
            print("* меняю \(fuelLevelPercent) на 100")
        } else if fuelLevelPercent < 0 {
            print("* значение < 0")
            self.fuelLevelPercent = 0
            print("* меняю \(fuelLevelPercent) на 0")
        }
    }
    
    func action(_ action: WindowActions) {
        switch action {
        case .openWindow:
            isWindowOpened = true
        case .closeWindow:
            isWindowOpened = false
        case .toggleWindow:
            isWindowOpened = isWindowOpened ? false : true
        }
    }
    
    func action(_ action: EngineActions) {
        switch action {
        case .startEngine:
            isEngineStarted = true
        case .stopEngine:
            isEngineStarted = false
        case .toggleEngine:
            isEngineStarted = isEngineStarted ? false : true
        }
    }
    
    func action(_ action: NewActionsType) {
        switch action {
        case .openHatch:
            isHatchOpened = true
        case .closeHatch:
            isHatchOpened = false
        case .toggleHatch:
            isHatchOpened = isHatchOpened ? false : true
        default:
            print("Это действие не поддерживается для данного типа машин")
        }
    }
    
    func status() -> String {
        """
        \n* уточняю текущий статус
        Пробег: \(mileage)км
        Уровень топлива: \(fuelLevelPercent)%
        Мотор: \(isEngineStarted ? "заведен" : "заглушен")
        Окна: \(isWindowOpened ? "открыты" : "закрыты")
        Люк: \(isHatchOpened ? "открыт" : "закрыт")
        """
    }
}

class TruckCar: CarDrivable {
    enum BodyType: String {
        case dump = "Самосвал"
        case pole = "Шасси"
        case concreteMixer = "Бетономешалка"
        case refrigirator = "Рефрижиратор"
        case cargoTank = "Контейнеровоз"
        case enclosed = "Тент"
    }
    
    let brand: String
    let model: String
    let productionYear: Int
    var mileage: Double = 0.0
    var fuelLevelPercent: Int = 100
    let bodyType: BodyType
    let truckCapacity: Int
    var truckCapacityFilled = 0
    var isWindowOpened: Bool = false
    var isEngineStarted: Bool = false
    
    init(brand: String, model: String, productionYear: Int, fuelLevel: Int, bodyType: BodyType, truckCapacity: Int) {
        self.brand = brand
        self.model = model
        self.productionYear = productionYear
        self.fuelLevelPercent = fuelLevel
        self.bodyType = bodyType
        self.truckCapacity = truckCapacity
        
        print("\n* создаю новый объект \(brand) \(model)")
        if fuelLevel > 100 {
            print("* введенное значение топлива > 100")
            self.fuelLevelPercent = 100
            print("* меняю \(fuelLevel) на 100")
        } else if fuelLevel < 0 {
            print("* введенное значение топлива < 0")
            self.fuelLevelPercent = 0
            print("* меняю \(fuelLevel) на 0")
        }
    }
    
    func action(_ action: NewActionsType) {
        switch action {
        case .loadCargo(let cargo):
            if cargo + truckCapacityFilled > truckCapacity {
                print("Ваш груз (\(cargo)кг) не поместится в кузов. Вы можете погрузить максимум \(truckCapacity)кг")
                } else {
                truckCapacityFilled += cargo
                print("Груз (\(cargo)кг) погружен. Вы можете загрузить еще \(truckCapacity - truckCapacityFilled)кг")
            }
        case .releaseCargo(let cargo):
            if cargo > truckCapacityFilled {
                print("В кузове меньше груза, чем вы запрашивали (\(cargo)кг). Сейчас погружено: \(truckCapacityFilled)кг")
                } else {
                truckCapacityFilled -= cargo
                print("Груз (\(cargo)кг) выгружен. В кузове осталось еще \(truckCapacityFilled)кг")
            }
        default:
            print("Это действие не поддерживается для данного типа машин")
        }
    }
    
    func status() -> String {
        """
        \n* уточняю текущий статус
        Пробег: \(mileage)км
        Уровень топлива: \(fuelLevelPercent)%
        Мотор: \(isEngineStarted ? "заведен" : "заглушен")
        Окна: \(isWindowOpened ? "открыты" : "закрыты")
        Загруженность: \(truckCapacityFilled > 0 ? "\(truckCapacityFilled)кг из \(truckCapacity)кг" : "Кузов пуст")
        """
    }
}

//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль.
var car1 = SportCar(brand: "Tesla", model: "Model S", productionYear: 2020, fuelLevel: 12, topSpeed: 320, accelerationTo100Time: 2)
car1.action(.toggleWindow)
car1.action(.toggleEngine)
car1.action(.openHatch)
print(car1)
print(car1.status())

var car2 = SportCar(brand: "LADA", model: "Ellada", productionYear: 2016, fuelLevel: 89, topSpeed: 240, accelerationTo100Time: 4)
car2.action(.openHatch)
car2.action(.loadCargo(cargo: 12))
print(car2)
print(car2.status())

var car3 = SportCar(brand: "KIA", model: "Rio", productionYear: 2004, fuelLevel: 15, topSpeed: 200, accelerationTo100Time: 10)
car3.action(.toggleEngine)
car3.action(.toggleWindow)
print(car3)
print(car3.status())

var truck = TruckCar(brand: "MAN", model: "MAN-503", productionYear: 2014, fuelLevel: 559, bodyType: .concreteMixer, truckCapacity: 560)
truck.action(.loadCargo(cargo: 268))
truck.action(.loadCargo(cargo: 468))
truck.action(.loadCargo(cargo: 102))
print(truck)
print(truck.status())

var truck2 = TruckCar(brand: "Kamaz", model: "M2", productionYear: 2007, fuelLevel: 99, bodyType: .dump, truckCapacity: 320)
truck2.action(.releaseCargo(cargo: 265))
truck2.action(.loadCargo(cargo: 302))
truck2.action(.toggleWindow)
print(truck2)
print(truck2.status())
