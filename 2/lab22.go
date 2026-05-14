package main

import "fmt"

func findLongestChain(trips [][2]string) string {
    // Карта: из какого города -> в какой город
    nextCity := make(map[string]string)
    // Множество всех городов
    allCities := make(map[string]bool)
    // Множество городов, куда можно приехать
    destinations := make(map[string]bool)
    
    // Заполняем контейнеры
    for _, trip := range trips {
        from := trip[0]
        to := trip[1]
        
        // Проверка на петлю (город сам в себя)
        if from == to {
            return "Ошибка"
        }
        
        nextCity[from] = to
        allCities[from] = true
        allCities[to] = true
        destinations[to] = true
    }
    
    // Ищем начальный город (который никуда не ведет как пункт назначения)
    start := ""
    for city := range allCities {
        if !destinations[city] {
            start = city
            break
        }
    }
    
    // Если начальный город не нашли - значит есть цикл
    if start == "" {
        return "Ошибка"
    }
    
    // Идем по цепочке до конца
    current := start
    for {
        if _, exists := nextCity[current]; !exists {
            break
        }
        current = nextCity[current]
    }
    
    // current - это конечный пункт
    return current
}

func main() {
    // Пример 1
    trips1 := [][2]string{
        {"Лондон", "Стамбул"},
        {"Новосибирск", "Лондон"},
        {"Стамбул", "Пекин"},
    }
    fmt.Println(findLongestChain(trips1)) // Пекин
    
    // Пример 2
    trips2 := [][2]string{
        {"Барнаул", "Новосибирск"},
    }
    fmt.Println(findLongestChain(trips2)) // Новосибирск
    
    // Пример 3 (петля)
    trips3 := [][2]string{
        {"Искитим", "Искитим"},
    }
    fmt.Println(findLongestChain(trips3)) // Ошибка
    
    // Пример 4 (цикл)
    trips4 := [][2]string{
        {"Москва", "Норильск"},
        {"Норильск", "Саратов"},
        {"Саратов", "Москва"},
    }
    fmt.Println(findLongestChain(trips4)) // Ошибка
}
