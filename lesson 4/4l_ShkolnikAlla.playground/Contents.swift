 // 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
 // 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
 // 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет truckCar, а какие – sportCar. Добавить эти действия в перечисление.
 // 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
 
 enum ActionType {
    case closeWindow
    case openWindow
    case startEngine
    case stopEngine
    case loadCargo(cargo: Int)
    case releaseCargo(cargo: Int)
    case openHatch
    case closeHatch
 }
 
 class Car {
    enum FuelType: String {
        case electric = "Электро"
        case gasoline = "Бензин"
        case diesel = "Дизель"
    }
    var brand: String
    var model: String
    var productionYear: Int
    var mileage = 0.0
    var fuelSource: FuelType
    var fuelLevel: Int
    var isWindowOpened = false
    var isEngineStarted = false
    
    init(
        brand: String,
        model: String,
        productionYear: Int,
        fuelSource: FuelType,
        fuelLevel: Int,
        isWindowOpened: Bool,
        isEngineStarted: Bool
    ) {
        self.brand = brand
        self.model = model
        self.fuelSource = fuelSource
        self.fuelLevel = fuelLevel
        self.productionYear = productionYear
        self.isWindowOpened = isWindowOpened
        self.isEngineStarted = isEngineStarted
        
        if fuelLevel > 100 {
            self.fuelLevel = 100
        } else if fuelLevel < 0 {
            self.fuelLevel = 0
        }
    }
    
    func doSomething(action: ActionType) {
        switch(action){
        case .openWindow:
            if isWindowOpened {
                print("* Окно уже было открыто")
            } else {
                isWindowOpened = true
                print("* Окно открыто")
            }
        case .closeWindow:
            if !isWindowOpened {
                print("* Окно уже закрыто")
            } else {
                isWindowOpened = false
                print("* Окно закрыто")
            }
        case .startEngine:
            if isEngineStarted {
                print("* Мотор уже был заведен ранее")
            } else {
                isEngineStarted == true
                print("* Мотор заведен!")
            }
        case .stopEngine:
            if !isEngineStarted {
                print("* Мотор уже был заглушен")
            } else {
                isEngineStarted == false
                print("* Заглушили мотор")
            }
        default:
            print("* Это действие недоступно, попробуйте сделать что-то еще")
            break
        }
    }
    
    func description() -> String {
        """
        Бренд: \(brand)
        Модель: \(model)
        Год выпуска: \(productionYear)
        Тип топлива: \(fuelSource.rawValue)
        """
    }
    
    func status() -> String {
        """
        Мотор: \(isEngineStarted ? "заведен" : "заглушен")
        Окна: \(isWindowOpened ? "открыты" : "закрыты")
        Уровень топлива: \(fuelLevel)%
        """
    }
 }
 
 final class TruckCar: Car {
    enum BodyType: String {
        case dump = "Самосвал"
        case pole = "Шасси"
        case concreteMixer = "Бетономешалка"
        case refrigirator = "Рефрижиратор"
        case cargoTank = "Контейнеровоз"
        case enclosed = "Тент"
    }
    var bodyType: BodyType
    var truckCapacity: Int
    var truckCapacityFilled = 0
    
    init(
        brand: String,
        model: String,
        productionYear: Int,
        fuelSource: FuelType,
        fuelLevel: Int,
        isWindowOpened: Bool,
        isEngineStarted: Bool,
        bodyType: BodyType,
        truckCapacity: Int,
        truckCapacityFilled: Int = 0
    ) {
        self.bodyType = bodyType
        self.truckCapacity = truckCapacity
        self.truckCapacityFilled = truckCapacityFilled
        super.init(
            brand: brand,
            model: model,
            productionYear: productionYear,
            fuelSource: fuelSource,
            fuelLevel: fuelLevel,
            isWindowOpened: isWindowOpened,
            isEngineStarted: isEngineStarted
        )
    }
    
    override func doSomething(action: ActionType) {
        switch(action){
        case .openWindow, .closeWindow, .startEngine, .stopEngine:
            super.doSomething(action: action)
        case .loadCargo(let cargo):
                if cargo + truckCapacityFilled > truckCapacity {
                    print("* Ваш груз (\(cargo)кг) не поместится в кузов. Вы можете погрузить максимум \(truckCapacity)кг")
                } else {
                    truckCapacityFilled += cargo
                    print("* Груз погружен. Вы можете загрузить еще  \(truckCapacity - truckCapacityFilled)кг")
                }
        case .releaseCargo(let cargo):
            if cargo > truckCapacityFilled {
                print("* В кузове меньше груза, чем вы запрашивали. Сейчас погружено \(truckCapacityFilled)кг")
            } else {
                truckCapacityFilled -= cargo
                print("* Груз выгружен. В кузове осталось еще \( truckCapacityFilled)кг")
            }
        default:
            print("* Это действие недоступно, попробуйте сделать что-то еще")
            break
        }
    }
    
    override func description() -> String {
        """
        \(super.description())
        Тип кузова: \(bodyType.rawValue)
        Вместимость кузова: \(truckCapacity)
        """
    }
    
    override func status() -> String {
        """
        \(super.status())
        \(truckCapacityFilled >= 0
            ? "Заполненность кузова: \(truckCapacityFilled)кг из \(truckCapacity)кг"
            : "Кузов пуст")
        """
    }
 }
 
 final class SportCar: Car {
    var topSpeed: Int
    var seatCount = 2
    var accelerationTo100Time: Int
    var isHatchOpened = false
    
    init(
        brand: String,
        model: String,
        productionYear: Int,
        fuelSource: FuelType,
        fuelLevel: Int,
        isWindowOpened: Bool,
        isEngineStarted: Bool,
        topSpeed: Int,
        accelerationTo100Time: Int
        
    ) {
        self.topSpeed = topSpeed
        self.accelerationTo100Time = accelerationTo100Time
        super.init(
            brand: brand,
            model: model,
            productionYear: productionYear,
            fuelSource: fuelSource,
            fuelLevel: fuelLevel,
            isWindowOpened: isWindowOpened,
            isEngineStarted: isEngineStarted
        )
    }
    
    override func doSomething(action: ActionType) {
        switch(action){
        case .openWindow, .closeWindow, .startEngine, .stopEngine:
            super.doSomething(action: action)
        case .openHatch:
            if isHatchOpened {
                print("* Люк уже был открыт")
            } else {
                isHatchOpened == true
                print("* Люк открыт!")
            }
        case .closeHatch:
            if !isHatchOpened {
                print("* Люк уже был закрыт")
            } else {
                isHatchOpened == false
                print("* Люк закрыт!")
            }
        default:
            print("Это действие недоступно, попробуйте сделать что-то еще")
            break
        }
    }
    
    override func description() -> String {
        """
        \(super.description())
        Максимальная скорость: \(topSpeed)
        Время разгона до 100 км/ч: \(accelerationTo100Time)
        """
    }
    
    override func status() -> String {
        """
        \(super.status())
        Люк: \(isHatchOpened ? "открыт" : "закрыт")
        """
    }
 }

//   5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//   6. Вывести значения свойств экземпляров в консоль.
 
 print("\n***")
 let solaris = Car(
    brand: "Hyundai",
    model: "Solaris",
    productionYear: 2016,
    fuelSource: .gasoline,
    fuelLevel: 45,
    isWindowOpened: false,
    isEngineStarted: false
 )
 
 print(solaris.description())
 solaris.doSomething(action: .closeWindow)
 solaris.doSomething(action: .startEngine)
 solaris.doSomething(action: .openWindow)
 print(solaris.status())
 
 print("\n***")
 let teslaS = SportCar(
    brand: "Tesla",
    model: "Model S",
    productionYear: 2019,
    fuelSource: .electric,
    fuelLevel: 100,
    isWindowOpened: false,
    isEngineStarted: false,
    topSpeed: 320,
    accelerationTo100Time: 2
 )
 
 teslaS.seatCount = 4
 print(teslaS.description())
 teslaS.doSomething(action: .startEngine)
 teslaS.doSomething(action: .openHatch)
 teslaS.doSomething(action: .stopEngine)
 print(teslaS.status())
 
 print("\n***")
 let kamaz = TruckCar(
    brand: "Камаз",
    model: "А1",
    productionYear: 2020,
    fuelSource: .diesel,
    fuelLevel: 89,
    isWindowOpened: false,
    isEngineStarted: true,
    bodyType: .refrigirator,
    truckCapacity: 380
 )
 print(kamaz.description())
 kamaz.doSomething(action: .loadCargo(cargo: 450))
 kamaz.doSomething(action: .loadCargo(cargo: 120))
 kamaz.doSomething(action: .loadCargo(cargo: 82))
 kamaz.doSomething(action: .releaseCargo(cargo: 50))
 kamaz.doSomething(action: .releaseCargo(cargo: 102))
 print(kamaz.status())
