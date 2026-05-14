def isCyclicShift(S, T):

    # Если длины разные, циклический сдвиг невозможен
    if len(S) != len(T):
        return False

    # Создаём строку из двух S подряд
    doubled = S + S

    # Проверяем встречается ли T внутри SS, если найдена => цикл сдвиг
    if doubled.find(T) != -1:
        return True

    return False


S = input("Введите строку S: ")
T = input("Введите строку T: ")

# Проверка на циклический сдвиг
if isCyclicShift(S, T):
    print("Yes")
else:
    print("No")