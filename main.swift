import Foundation

// class inheritance
class Parent {
    var someGenes = "101010001001000010111"
}

class Descendant0: Parent {
    var ownGenes = "00000000"
}

class Descendant1: Parent {
    var ownGenes = "11111111"
}

let d0 = Descendant0()
print("Descendant0 genes = \(d0.someGenes) + \(d0.ownGenes)")

let d1 = Descendant1()
print("Descendant1 genes = \(d1.someGenes) + \(d1.ownGenes)")

print()

// House task
class House {
    let width, height: Int
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    func create() {
        print("Size: \(self.width * self.height)")
    }
    
    func destroy() {
        print("The house is destroyed")
    }
}

let smallHouse = House(width: 30, height: 40)
smallHouse.create()
smallHouse.destroy()

print()

// Students task
struct Student {
    let name: String
    let age: Int
    let gpa: Double
}
class ClassSort {
    var students: [Student]
    init(arr: [Student]) {
        self.students = arr
    }
    
    func sortByName(desc: Bool) -> [Student] {
        if desc {
            self.students.sort(by: { $0.name.count > $1.name.count })
        }
        else {
            self.students.sort(by: { $0.name.count < $1.name.count })
        }
        return self.students
    }
    
    func sortByAge(desc: Bool) -> [Student]  {
        if desc {
            self.students.sort(by: { $0.age > $1.age })
        }
        else {
            self.students.sort(by: { $0.age < $1.age })
        }
        return self.students
    }
    
    func sortByGpa(desc: Bool) -> [Student]  {
        if desc {
            self.students.sort(by: { $0.gpa > $1.gpa })
        }
        else {
            self.students.sort(by: { $0.gpa < $1.gpa })
        }
        return self.students
    }
    
    
    class func repr(arr: [Student]) {
        for (n, stud) in arr.enumerated() {
            print("\(n): Name: \(stud.name) Age: \(stud.age) GPA: \(stud.gpa)")
        }
    }
}

let smallClass: [Student] = [
    Student(name: "Anna", age: 20, gpa: 5.0), Student(name: "George", age: 50, gpa: 3.1),
    Student(name: "Anaconda", age: 18, gpa: 2.5), Student(name: "Corca", age: 85, gpa: 4.1)
]

let sorter: ClassSort = ClassSort(arr: smallClass)
print("By Name Desc")
print(ClassSort.repr(arr: sorter.sortByName(desc: true)))
print()
print("By Name not Desc")
print(ClassSort.repr(arr: sorter.sortByName(desc: false)))
print()
print("By Age Desc")
print(ClassSort.repr(arr: sorter.sortByAge(desc: true)))
print()
print("By GPA Desc")
print(ClassSort.repr(arr: sorter.sortByGpa(desc: true)))

// Классы при присваивании не копируются а ссылаются на существующий объект,
//  в то время как струкутуры полностью копируются. Также классы поддерживают 
//  наследование и обладают деструктором (deinitializer)

// poker
enum SUITS: Int, CaseIterable {
    case CLUBS
    case DIAMONDS
    case HEARTS
    case SPADES
}

enum VALUES: Int, CaseIterable {
    case TWO = 2
    case THREE = 3
    case FOUR = 4
    case FIVE = 5
    case SIX = 6
    case SEVEN = 7
    case EIGHT = 8
    case NINE = 9
    case TEN = 10
    case JACK = 11
    case QUEEN = 12
    case KING = 13
    case ACE = 14
}

struct Card {
    let suit: SUITS
    let val: VALUES
    init() {
        self.suit = SUITS.allCases.randomElement()!
        self.val = VALUES.allCases.randomElement()!
    }
    init(suit: SUITS, val: VALUES) {
        self.suit = suit
        self.val = val
    }
}

class Poker {
    var combinations: [[Card]] = []
    init(numPlayers: Int) {
        self.combinations = self.genRandomCombination(numPlayers: numPlayers)
    }
    
    func genRandomCombination(numPlayers: Int) -> [[Card]] {
        var comb: [[Card]] = []
        for _ in 0...numPlayers {
            comb.append(self.genRandomHands())
        }
        return comb
    }
    
    func genRandomHands() -> [Card]{
        var randomHands: [Card] = []
        for _ in 0...4 {
            randomHands.append(Card())
        }
        return randomHands
    }
    
    func recognseAll() {
        for comb in self.combinations {
            self.reprOneCombination(cards: comb)
            self.recogniseCombination(comb: comb)
            print()
        }
    }
    
    func recogniseCombination(comb: [Card]) {
        
        let comb = comb.sorted( by: {$0.val.rawValue > $1.val.rawValue} )
        
        var equalValues: [VALUES: Int] = [VALUES: Int]()
        comb.forEach { card in
            equalValues[card.val, default: 0] += 1
        }
        
        var twoPares: [Int: Int] = [Int: Int]()
        equalValues.values.forEach { cnt in
            twoPares[cnt, default: 0] += 1
        }
        
        var equalSuits: [SUITS: Int] = [SUITS: Int]()
        comb.forEach { card in
            equalSuits[card.suit, default: 0] += 1
        }
        
        
        var stritSeach: [Int] = [Int]()
        for i in 0...(comb.count-2) {
            stritSeach.append(comb[i].val.rawValue - comb[i+1].val.rawValue)
        }
        let isIncreasing = Set(stritSeach).count == 1
        
        if equalValues.values.contains(5) && equalSuits.values.contains(5) {
            print("Флеш Рояль")
        }
        else if equalSuits.values.contains(5) && isIncreasing {
            print("Стрит флеш")
        }
        else if equalValues.values.contains(4) {
            print("Каре")
        }
        else if equalSuits.values.contains(5) {
            print("Флеш")
        }
        else if isIncreasing {
            print("Стрит")
        }
        else if equalValues.values.contains(3) {
            print("Тройка")
        }
        else if twoPares.values.contains(2) {
            print("Две пары")
        }
        else if equalValues.values.contains(2) {
            print("Пара")
        }
        else {
            print("Ничего")
        }
    }
    
    func reprOneCombination(cards: [Card]) {
        for card in cards {
            print(card)
        }
    }
}

let testPoker: Poker = Poker(numPlayers: 1)

// tests
// Флеш Рояль
testPoker.recogniseCombination(comb: [
    Card(suit: SUITS.CLUBS, val: VALUES.ACE),
    Card(suit: SUITS.CLUBS, val: VALUES.ACE),
    Card(suit: SUITS.CLUBS, val: VALUES.ACE),
    Card(suit: SUITS.CLUBS, val: VALUES.ACE),
    Card(suit: SUITS.CLUBS, val: VALUES.ACE)
])
// Стрит флеш
testPoker.recogniseCombination(comb: [
    Card(suit: SUITS.CLUBS, val: VALUES.TWO),
    Card(suit: SUITS.CLUBS, val: VALUES.THREE),
    Card(suit: SUITS.CLUBS, val: VALUES.FOUR),
    Card(suit: SUITS.CLUBS, val: VALUES.FIVE),
    Card(suit: SUITS.CLUBS, val: VALUES.SIX)
])
// Каре
testPoker.recogniseCombination(comb: [
    Card(suit: SUITS.CLUBS, val: VALUES.TWO),
    Card(suit: SUITS.CLUBS, val: VALUES.TWO),
    Card(suit: SUITS.CLUBS, val: VALUES.TWO),
    Card(suit: SUITS.CLUBS, val: VALUES.TWO),
    Card(suit: SUITS.CLUBS, val: VALUES.SIX)
])
// Флеш
testPoker.recogniseCombination(comb: [
    Card(suit: SUITS.CLUBS, val: VALUES.TWO),
    Card(suit: SUITS.CLUBS, val: VALUES.TWO),
    Card(suit: SUITS.CLUBS, val: VALUES.EIGHT),
    Card(suit: SUITS.CLUBS, val: VALUES.TWO),
    Card(suit: SUITS.CLUBS, val: VALUES.SIX)
])
// Стрит
testPoker.recogniseCombination(comb: [
    Card(suit: SUITS.CLUBS, val: VALUES.TWO),
    Card(suit: SUITS.DIAMONDS, val: VALUES.THREE),
    Card(suit: SUITS.CLUBS, val: VALUES.FOUR),
    Card(suit: SUITS.CLUBS, val: VALUES.FIVE),
    Card(suit: SUITS.CLUBS, val: VALUES.SIX)
])
// Тройка
testPoker.recogniseCombination(comb: [
    Card(suit: SUITS.CLUBS, val: VALUES.TWO),
    Card(suit: SUITS.DIAMONDS, val: VALUES.TWO),
    Card(suit: SUITS.CLUBS, val: VALUES.TWO),
    Card(suit: SUITS.CLUBS, val: VALUES.FIVE),
    Card(suit: SUITS.CLUBS, val: VALUES.SIX)
])
// Две пары
testPoker.recogniseCombination(comb: [
    Card(suit: SUITS.CLUBS, val: VALUES.TWO),
    Card(suit: SUITS.DIAMONDS, val: VALUES.TWO),
    Card(suit: SUITS.CLUBS, val: VALUES.FIVE),
    Card(suit: SUITS.CLUBS, val: VALUES.FIVE),
    Card(suit: SUITS.CLUBS, val: VALUES.SIX)
])
// Пара
testPoker.recogniseCombination(comb: [
    Card(suit: SUITS.CLUBS, val: VALUES.TWO),
    Card(suit: SUITS.DIAMONDS, val: VALUES.TWO),
    Card(suit: SUITS.CLUBS, val: VALUES.SEVEN),
    Card(suit: SUITS.CLUBS, val: VALUES.FIVE),
    Card(suit: SUITS.CLUBS, val: VALUES.SIX)
])

print()
print("Random test")

// Рандомный тест
let poker: Poker = Poker(numPlayers: 10)
poker.recognseAll()

