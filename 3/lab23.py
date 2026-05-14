input_str = input()  # Получаем строку от пользователя

current_num = ""  # Цифры текущего числа

# Проходим по каждому символу введённой строки
i = 0
while i <= len(input_str):
    if i < len(input_str):
        c = input_str[i]
    else:
        c = ''  # Для обработки конца строки
    
    # Проверяем является ли символ цифрой
    if i < len(input_str) and '0' <= c <= '9':
        current_num += c
    else:
        # Если это не цифра, проверяем есть ли накопленное число и переводим эту строку в число
        if current_num:  # if not current_num.empty()
            num = 0
            for digit in current_num:
                num = num * 10 + (ord(digit) - ord('0'))
            
            # Проверка на натуральное число
            if num <= 0:
                print(f"Ошибка: число {num} не натуральное!")
                exit(1)
            
            # Если число однозначное
            if num <= 9:
                print("- ", end='')  # end='' чтобы не переводить строку
            else:
                # Количество чётных цифр в числе
                even_count = 0
                temp = num
                
                while temp > 0:
                    digit = temp % 10
                    
                    if digit % 2 == 0:
                        even_count += 1
                    
                    temp = temp // 10
                
                print(f"{even_count} ", end='')  # результат
            
            current_num = ""  # очищаем накопленное число для следующего
        
        # Проверка на некорректные символы
        if i < len(input_str) and c != ' ':
            print(f"Ошибка: недопустимый символ '{c}'!")
            exit(1)
    
    i += 1