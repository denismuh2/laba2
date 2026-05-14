def findLongestChain(trips):
    # Карта: из какого города -> в какой город
    nextCity = {}
    # Множество всех городов
    allCities = set()
    # Множество городов, куда можно приехать
    destinations = set()
    
    # Заполняем контейнеры
    for from_city, to_city in trips:
        # Проверка на петлю (город сам в себя)
        if from_city == to_city:
            return "Ошибка"
        
        nextCity[from_city] = to_city
        allCities.add(from_city)
        allCities.add(to_city)
        destinations.add(to_city)
    
    # Ищем начальный город (который никуда не ведет как пункт назначения)
    start = ""
    for city in allCities:
        if city not in destinations:
            start = city
            break
    
    # Если начальный город не нашли - значит есть цикл
    if not start:
        return "Ошибка"
    
    # Идем по цепочке до конца
    current = start
    while current in nextCity:
        current = nextCity[current]
    
    # current - это конечный пункт
    return current


# Пример 1
trips1 = [
    ("Лондон", "Стамбул"),
    ("Новосибирск", "Лондон"),
    ("Стамбул", "Пекин")
]
print(findLongestChain(trips1))  # Пекин

# Пример 2
trips2 = [
    ("Барнаул", "Новосибирск")
]
print(findLongestChain(trips2))  # Новосибирск

# Пример 3 (петля)
trips3 = [
    ("Искитим", "Искитим")
]
print(findLongestChain(trips3))  # Ошибка

# Пример 4 (цикл)
trips4 = [
    ("Москва", "Норильск"),
    ("Норильск", "Саратов"),
    ("Саратов", "Москва")
]
print(findLongestChain(trips4))  # Ошибка
