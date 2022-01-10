import Foundation

class Person {
    enum Gender {
        case female
        case male
    }
    let firstName: String
    var nickName: String?
    var familyName: String
    let gender: Gender
    var age: Int
    var passportNumber: String?
    
    init(firstName: String, nickName: String, familyName: String, gender: Gender, age: Int, passportNumber: String) {
        self.firstName = firstName
        self.nickName = nickName
        self.familyName = familyName
        self.gender = gender
        self.passportNumber = passportNumber
        self.age = age
    }
    init(firstName: String, familyName: String, gender: Gender, age: Int) {
        self.firstName = firstName
        self.familyName = familyName
        self.gender = gender
        self.age = age
    }
    init(firstName: String, nickName: String, familyName: String, age: Int, gender: Gender) {
        self.firstName = firstName
        self.nickName = nickName
        self.familyName = familyName
        self.gender = gender
        self.age = age
    }
    init(firstName: String, familyName: String, age: Int, gender: Gender, passportNumber: String) {
        self.firstName = firstName
        self.familyName = familyName
        self.gender = gender
        self.passportNumber = passportNumber
        self.age = age
    }
}

enum StudentError: String, Error {
    case noNickName = "нет никнейма"
    case noPassportNumber = "нет паспорта"
    case noScores = "нет оценок"
}

//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
class Student: Person {
    let classTitle: String
    var scores = [Int]()
    
    init(firstName: String, nickName: String, familyName: String, age: Int, gender: Gender, passportNumber: String, classTitle: String) {
        self.classTitle = classTitle
        super.init(firstName: firstName, nickName: nickName, familyName: familyName, gender: gender, age: age, passportNumber: passportNumber)
    }
    init(firstName: String, familyName: String, age: Int, gender: Gender, classTitle: String) {
        self.classTitle = classTitle
        super.init(firstName: firstName, familyName: familyName, gender: gender, age: age)
    }
    init(firstName: String, nickName: String, familyName: String, age: Int, gender: Gender, classTitle: String) {
        self.classTitle = classTitle
        super.init(firstName: firstName, nickName: nickName, familyName: familyName, age: age, gender: gender)
    }
    init(firstName: String,  familyName: String, age: Int, gender: Gender, passportNumber: String, classTitle: String) {
        self.classTitle = classTitle
        super.init(firstName: firstName, familyName: familyName, age: age, gender: gender, passportNumber: passportNumber)
    }
    
    func addScore(score: Int) {
        scores.append(score)
    }
    func getAvgScore() -> (Double?, StudentError?) {
        var avgScore = 0.0
        guard Double(scores.count) > 0 else {
            return (nil, StudentError.noScores)
        }
        for score in scores {
            avgScore += Double(score)
        }
        avgScore = avgScore / Double(scores.count)
        return (avgScore, nil)
    }
    func getStudentNickName() -> (String?, StudentError?) {
        guard self.nickName != nil else {
            return (nil, StudentError.noNickName)
        }
        return (self.nickName, nil)
    }
    func getPassportNumber() -> (String?, StudentError?) {
        guard self.passportNumber != nil else {
            return (nil, StudentError.noPassportNumber)
        }
        return (self.passportNumber, nil)
    }
}

let student1 = Student(firstName: "Сергей", nickName: "\"Бобер\"", familyName: "Бобров", age: 13, gender: .male, classTitle: "8A")
let avgScore = student1.getAvgScore()
if let score = avgScore.0 {
    print ("Средний балл ученика \(student1.firstName) \(student1.familyName) - \(score)")
} else if let error = avgScore.1 {
    print ("У ученика \(student1.firstName) \(student1.familyName) \(error.rawValue)")
}

enum TeacherError: Error {
    case cannotHaveMaidenName
    case noMaidenName
    case noPassportNumber
    case noNickName
    case noBonuses
}

//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.
class Teacher: Person {
    enum FamilyStatus {
        case single
        case married
        case divorced
        case widow
    }

    var maidenName: String?
    var familyStatus: FamilyStatus
    var profession: String
    var serviceExperience: Int
    var salary: Int
    var bonusAmount = 0
    var isTeacherAwardOwner = false

    init(firstName: String, nickName: String, familyName: String, gender: Gender, age: Int, passportNumber: String, familyStatus: FamilyStatus, profession: String, serviceExperience: Int, salary: Int, isTeacherAwardOwner: Bool) {
        self.familyStatus = familyStatus
        self.profession = profession
        self.serviceExperience = serviceExperience
        self.salary = salary
        self.isTeacherAwardOwner = isTeacherAwardOwner
        
        if self.isTeacherAwardOwner {
            self.bonusAmount += 10000
        }
        if self.serviceExperience >= 10 {
            self.bonusAmount += self.serviceExperience * 500
        }
        super.init(firstName: firstName, nickName: nickName, familyName: familyName, gender: gender, age: age, passportNumber: passportNumber)
    }
    init(firstName: String, nickName: String, familyName: String, age: Int, gender: Gender, familyStatus: FamilyStatus, profession: String, serviceExperience: Int, salary: Int, isTeacherAwardOwner: Bool) {
        self.familyStatus = familyStatus
        self.profession = profession
        self.serviceExperience = serviceExperience
        self.salary = salary
        self.isTeacherAwardOwner = isTeacherAwardOwner
        self.serviceExperience = serviceExperience
        
        super.init(firstName: firstName, nickName: nickName, familyName: familyName, age: age, gender: gender)
    }
    init(firstName: String, familyName: String, age: Int, gender: Gender, passportNumber: String, familyStatus: FamilyStatus, profession: String, serviceExperience: Int, salary: Int, isTeacherAwardOwner: Bool) {
        self.familyStatus = familyStatus
        self.profession = profession
        self.isTeacherAwardOwner = isTeacherAwardOwner
        self.salary = salary
        self.serviceExperience = serviceExperience
        
        super.init(firstName: firstName, familyName: familyName, age: age, gender: gender, passportNumber: passportNumber)
    }
    
    func setMaidenName(newMaidenName: String) throws {
        guard self.gender == Gender.female else {
            throw TeacherError.cannotHaveMaidenName
        }
        self.maidenName = newMaidenName
    }
    func getMaidenName() throws -> String {
        guard self.gender == Gender.female else {
            throw TeacherError.cannotHaveMaidenName
        }
        guard let name = self.maidenName else {
            throw TeacherError.noMaidenName
        }
        return name
    }
    func getPassportNumber() throws -> String {
        guard let passportNumber = self.passportNumber else {
            throw TeacherError.noPassportNumber
        }
        return passportNumber
    }
    func getNickName() throws -> String {
        guard let nickname = self.nickName else {
            throw TeacherError.noNickName
        }
        return nickname
    }
    func setSalary(newSalary: Int) {
        self.salary = newSalary + self.bonusAmount
    }
}


let teacher = Teacher(firstName: "Август", nickName: "Третий", familyName: "Третьих", age: 47, gender: .male, familyStatus: .divorced, profession: "Учитель истории", serviceExperience: 18, salary: 52000, isTeacherAwardOwner: false)

do {
    try teacher.getPassportNumber()
} catch TeacherError.noPassportNumber {
    print("\(teacher.profession) по имени \(teacher.firstName) \(teacher.familyName) потерял свой паспорт!")
}

do {
    try teacher.getMaidenName()
} catch TeacherError.cannotHaveMaidenName {
    print("\(teacher.firstName) \(teacher.familyName) - мужчина, он не может иметь девичьей фамилии")
} catch TeacherError.noMaidenName {
    print("\(teacher.profession) по имени \(teacher.firstName) \(teacher.familyName) не имеет девичьей фамилии")
}

do {
    try print("\(teacher.firstName) \(teacher.familyName) получил прозвище - \"\(teacher.getNickName())\"")
} catch TeacherError.noNickName {
    print("\(teacher.firstName) \(teacher.familyName) не еще получил прозвища")
}

print("\(teacher.firstName) \(teacher.familyName) получает \(teacher.salary)р в месяц")
