import Foundation

func findLongestChain(_ trips: [(String, String)]) -> String {
    // Карта: из какого города -> в какой город
    var nextCity: [String: String] = [:]
    // Множество всех городов
    var allCities = Set<String>()
    // Множество городов, куда можно приехать
    var destinations = Set<String>()
    
    // Заполняем контейнеры
    for trip in trips {
        let from = trip.0
        let to = trip.1
        
        // Проверка на петлю (город сам в себя)
        if from == to {
            return "Ошибка"
        }
        
        nextCity[from] = to
        allCities.insert(from)
        allCities.insert(to)
        destinations.insert(to)
    }
    
    // Ищем начальный город (который никуда не ведет как пункт назначения)
    var start = ""
    for city in allCities {
        if !destinations.contains(city) {
            start = city
            break
        }
    }
    
    // Если начальный город не нашли - значит есть цикл
    if start.isEmpty {
        return "Ошибка"
    }
    
    // Идем по цепочке до конца
    var current = start
    while nextCity.keys.contains(current) {
        current = nextCity[current]!
    }
    
    // current - это конечный пункт
    return current
}

// Пример 1
let trips1: [(String, String)] = [
    ("Лондон", "Стамбул"),
    ("Новосибирск", "Лондон"),
    ("Стамбул", "Пекин")
]
print(findLongestChain(trips1)) // Пекин

// Пример 2
let trips2: [(String, String)] = [
    ("Барнаул", "Новосибирск")
]
print(findLongestChain(trips2)) // Новосибирск

// Пример 3 (петля)
let trips3: [(String, String)] = [
    ("Искитим", "Искитим")
]
print(findLongestChain(trips3)) // Ошибка

// Пример 4 (цикл)
let trips4: [(String, String)] = [
    ("Москва", "Норильск"),
    ("Норильск", "Саратов"),
    ("Саратов", "Москва")
]
print(findLongestChain(trips4)) // Ошибка
