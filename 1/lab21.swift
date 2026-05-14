import Foundation

func isCyclicShift(_ S: String, _ T: String) -> Bool {

    // Если длины разные, циклический сдвиг невозможен
    if S.count != T.count {
        return false
    }

    // Создаём строку из двух S подряд
    let doubled = S + S

    // Проверяем встречается ли T внутри SS, если найдена => цикл сдвиг
    if doubled.contains(T) {
        return true
    }

    return false
}

print("Введите строку S: ", terminator: "")
let S = readLine() ?? ""

print("Введите строку T: ", terminator: "")
let T = readLine() ?? ""

// Проверка на циклический сдвиг
if isCyclicShift(S, T) {
    print("Yes")
} else {
    print("No")
}