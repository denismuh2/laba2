#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>

using namespace std;

string findLongestChain(const vector<pair<string, string>>& trips) {
    // Карта: из какого города -> в какой город
    map<string, string> nextCity;
    // Множество всех городов
    set<string> allCities;
    // Множество городов, куда можно приехать
    set<string> destinations;
    
    // Заполняем контейнеры
    for (const auto& trip : trips) {
        string from = trip.first;
        string to = trip.second;
        
        // Проверка на петлю (город сам в себя)
        if (from == to) {
            return "Ошибка";
        }
        
        nextCity[from] = to;
        allCities.insert(from);
        allCities.insert(to);
        destinations.insert(to);
    }
    
    // Ищем начальный город (который никуда не ведет как пункт назначения)
    string start;
    for (const auto& city : allCities) {
        if (destinations.find(city) == destinations.end()) {
            start = city;
            break;
        }
    }
    
    // Если начальный город не нашли - значит есть цикл
    if (start.empty()) {
        return "Ошибка";
    }
    
    // Идем по цепочке до конца
    string current = start;
    while (nextCity.find(current) != nextCity.end()) {
        current = nextCity[current];
    }
    
    // current - это конечный пункт
    return current;
}

int main() {
    // Пример 1
    vector<pair<string, string>> trips1 = {
        {"Лондон", "Стамбул"},
        {"Новосибирск", "Лондон"},
        {"Стамбул", "Пекин"}
    };
    cout << findLongestChain(trips1) << endl; // Пекин
    
    // Пример 2
    vector<pair<string, string>> trips2 = {
        {"Барнаул", "Новосибирск"}
    };
    cout << findLongestChain(trips2) << endl; // Новосибирск
    
    // Пример 3 (петля)
    vector<pair<string, string>> trips3 = {
        {"Искитим", "Искитим"}
    };
    cout << findLongestChain(trips3) << endl; // Ошибка
    
    // Пример 4 (цикл)
    vector<pair<string, string>> trips4 = {
        {"Москва", "Норильск"},
        {"Норильск", "Саратов"},
        {"Саратов", "Москва"}
    };
    cout << findLongestChain(trips4) << endl; // Ошибка
    
    return 0;
}
