package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Scan()
	input := scanner.Text()
	
	currentNum := ""  // Цифры текущего числа
	
	// Проходим по каждому символу введённой строки
	for i := 0; i <= len(input); i++ {
		var c byte
		if i < len(input) {
			c = input[i]
		}
		
		// Проверяем является ли символ цифрой
		if i < len(input) && c >= '0' && c <= '9' {
			currentNum += string(c)
		} else {
			// Если это не цифра, проверяем есть ли накопленное число и переводим эту строку в число
			if len(currentNum) > 0 {
				num := 0
				for _, digitChar := range currentNum {
					digit := int(digitChar - '0')
					num = num*10 + digit
				}
				
				// Проверка на натуральное число
				if num <= 0 {
					fmt.Printf("Ошибка: число %d не натуральное!\n", num)
					os.Exit(1)
				}
				
				// Если число однозначное
				if num <= 9 {
					fmt.Print("- ")
				} else {
					// Количество чётных цифр в числе
					evenCount := 0
					temp := num
					
					for temp > 0 {
						digit := temp % 10
						
						if digit%2 == 0 {
							evenCount++
						}
						
						temp = temp / 10
					}
					
					fmt.Print(evenCount, " ") // результат
				}
				
				currentNum = "" // очищаем накопленное число для следующего
			}
			
			// Проверка на некорректные символы
			if i < len(input) && c != ' ' {
				fmt.Printf("Ошибка: недопустимый символ '%c'!\n", c)
				os.Exit(1)
			}
		}
	}
}