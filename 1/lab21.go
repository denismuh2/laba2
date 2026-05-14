package main

import (
	"fmt"
	"strings"
)

func isCyclicShift(S string, T string) bool {

	// Если длины разные, циклический сдвиг невозможен
	if len(S) != len(T) {
		return false
	}

	// Создаём строку из двух S подряд
	doubled := S + S

	// Проверяем встречается ли T внутри SS, если найдена => цикл сдвиг
	if strings.Contains(doubled, T) {
		return true
	}

	return false
}

func main() {

	var S, T string

	fmt.Print("Введите строку S: ")
	fmt.Scan(&S)

	fmt.Print("Введите строку T: ")
	fmt.Scan(&T)

	// Проверка на циклический сдвиг
	if isCyclicShift(S, T) {
		fmt.Println("Yes")
	} else {
		fmt.Println("No")
	}
}