//1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.

struct SportCar {
    var brand: String
    var model: String
    var productionYear = 2020
    var trunkCapacity = 580
    var trunkCapacityFilled = 0
    var isEngineRunned = false
    var isWindowsOpened = false
    
    init (brand: String, model: String, productionYear: Int, trunkCapacity: Int, trunkCapacityFilled: Int, isEngineRunned: Bool, isWindowsOpened: Bool) {
        self.brand = brand
        self.model = model
        self.productionYear = productionYear
        self.trunkCapacity = trunkCapacity
        self.trunkCapacityFilled = trunkCapacityFilled
        self.isEngineRunned = isEngineRunned
        self.isWindowsOpened = isWindowsOpened
    }
    
    func description() {
        print("\nОписание машины \(brand) \(model):")
        print("Производитель: \(brand)")
        print("Модель: \(model)")
        print("Год выпуска: \(productionYear)")
        print("Объем груза: \(trunkCapacity)л")
    }
    
    mutating func action (Action: Action) {
        switch (Action) {
        case .runEngine:
            if isEngineRunned {
                print("Машина уже заведена")
            } else {
                isEngineRunned = true
                print("Двигатель машины заведен")
            }
        case .stopEngine:
            if !isEngineRunned {
                print("Машина и так не заведена")
            } else {
                isEngineRunned = false
                print("Мотор машины заглушен")
            }
        case .openWindows:
            isWindowsOpened = true
            print("Окна открыты")
        case .closeWindows:
            isWindowsOpened = false
            print("Окна закрыты")
            case .loadLuggage (let weight):
                if weight == 0 {
                    print("Вы не положили груз")
                } else if trunkCapacity < trunkCapacityFilled + weight {
                    print("Этот груз не поместится в машину, попробуйте что-то выгрузить")
                } else {
                    trunkCapacityFilled += weight
                    print("Груз загружен, в машину еще поместится \(trunkCapacity - trunkCapacityFilled)кг груза")
                }
            case .unloadLuggage (let weight):
                if weight == 0 {
                    print("Введите вес груза")
                } else if trunkCapacityFilled < weight {
                    trunkCapacityFilled = 0
                    print("Груз выгружен, но его было меньше чем вы запрашивали")
                } else {
                    trunkCapacityFilled -= weight
                    print("Груз выгружен, в машине осталось \(trunkCapacityFilled)кг груза")
                }
        }
    }
}

struct TruckCar {
    
    enum BodyType: String{
        case dump = "Самосвал"
        case pole = "Шасси"
        case concreteMixer = "Бетономешалка"
        case log = "Трубовоз"
        case enclosed = "Тент"
        case autoTransporter = "Автовоз"
        case cargoTank = "Контейнеровоз"
    }
    
    var brand: String
    var model: String
    var bodytype: BodyType = .enclosed
    var productionYear: Int
    var trunkCapacity: Int
    var trunkCapacityFilled = 0
    var isEngineRunned = false
    var isWindowsOpened = false
    
    func description() {
        print("\nОписание грузовика \(brand) \(model):")
        print("Производитель: \(brand)")
        print("Модель: \(model)")
        print("Тип: \(bodytype.rawValue)")
        print("Год выпуска: \(productionYear)")
        print("Объем груза: \(trunkCapacity)л")
    }
    
    mutating func action (Action: Action) {
        switch (Action) {
            case .runEngine:
                if isEngineRunned {
                    print("Грузовик уже заведен")
                } else {
                    isEngineRunned = true
                    print("Грузовик заведен")
                }
            case .stopEngine:
                if !isEngineRunned {
                    print("Грузовик и так не заведен")
                } else {
                    isEngineRunned = false
                    print("Мотор грузовика заглушен")
                }
            case .openWindows:
                isWindowsOpened = true
                print("Окна открыты")
            case .closeWindows:
                isWindowsOpened = false
                print("Окна закрыты")
            case .loadLuggage (let weight):
                if weight == 0 {
                    print("Вы не положили груз")
                } else if trunkCapacity < trunkCapacityFilled + weight {
                    print("Этот груз не поместится в кузов, попробуйте что-то выгрузить")
                } else {
                    trunkCapacityFilled += weight
                    print("Груз загружен, в кузов еще поместится \(trunkCapacity - trunkCapacityFilled)кг груза")
                }
            case .unloadLuggage  (let weight):
                if weight == 0 {
                    print("Введите вес груза")
                } else if trunkCapacityFilled < weight {
                    trunkCapacityFilled = 0
                    print("Груз выгружен, но его было меньше чем вы запрашивали")
                } else {
                    trunkCapacityFilled -= weight
                    print("Груз выгружен, в кузове осталось \(trunkCapacityFilled)кг груза")
                }
        }
    }
}

//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
enum Action {
    case runEngine
    case stopEngine
    case openWindows
    case closeWindows
    case loadLuggage (capacity: Int)
    case unloadLuggage (capacity: Int)
}

//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
var modelS = SportCar.init(brand: "Tesla", model: "Model S", productionYear: 2020, trunkCapacity: 793, trunkCapacityFilled: 0, isEngineRunned: false, isWindowsOpened: false)
var bmwX6 = SportCar.init(brand: "BMW", model: "X6", productionYear: 2020, trunkCapacity: 580, trunkCapacityFilled: 0, isEngineRunned: false, isWindowsOpened: false)
var manTGS = TruckCar.init(brand: "MAN", model: "TGS", bodytype: .dump, productionYear: 2013, trunkCapacity: 5680, trunkCapacityFilled: 356, isEngineRunned: false, isWindowsOpened: false)

manTGS.action(Action: .unloadLuggage(capacity: 8500))
manTGS.action(Action: .runEngine)
manTGS.action(Action: .loadLuggage(capacity: 1392))
manTGS.action(Action: .unloadLuggage(capacity: 678))
modelS.action(Action: .runEngine)
modelS.action(Action: .runEngine)
modelS.action(Action: .loadLuggage(capacity: 7560))
modelS.action(Action: .loadLuggage(capacity: 23))

//6. Вывести значения свойств экземпляров в консоль.
manTGS.description()
modelS.description()
bmwX6.description()
