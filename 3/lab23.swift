import Foundation

// Читаем строку
guard let input = readLine() else {
    print("Ошибка: не удалось прочитать строку")
    exit(1)
}

var currentNum = ""  // Цифры текущего числа

// Проходим по каждому символу введённой строки
for i in 0...input.count {
    let c: Character
    if i < input.count {
        c = input[input.index(input.startIndex, offsetBy: i)]
    } else {
        // Для обработки конца строки
        c = "\0"
    }
    
    // Проверяем является ли символ цифрой
    if i < input.count && c >= "0" && c <= "9" {
        currentNum.append(c)
    }
    else {
        // Если это не цифра, проверяем есть ли накопленное число и переводим эту строку в число
        if !currentNum.isEmpty {
            var num = 0
            for digitChar in currentNum {
                let digit = Int(String(digitChar))!
                num = num * 10 + digit
            }
            
            // Проверка на натуральное число
            if num <= 0 {
                print("Ошибка: число \(num) не натуральное!")
                exit(1)
            }
            
            // Если число однозначное
            if num <= 9 {
                print("- ", terminator: "")
            }
            else {
                // Количество чётных цифр в числе
                var evenCount = 0
                var temp = num
                
                while temp > 0 {
                    let digit = temp % 10
                    
                    if digit % 2 == 0 {
                        evenCount += 1
                    }
                    
                    temp = temp / 10
                }
                
                print(evenCount, terminator: " ")  // результат
            }
            
            currentNum = ""  // очищаем накопленное число для следующего
        }
        
        // Проверка на некорректные символы
        if i < input.count && c != " " {
            print("Ошибка: недопустимый символ '\(c)'!")
            exit(1)
        }
    }
}
