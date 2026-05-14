;Анализ натуральных чисел в строке


section .data
    input       times 256 db 0   ; массив для хранения введенной строки
    dash        db '-', ' ', 0
    space       db ' ', 0
    newline     db 10, 0
    error_char  db 'Ошибка: недопустимый символ!'
    fmt_int     db "%d", 0

section .bss
    currentNum  resb 32          ; буфер для накопления цифр текущего числа

section .text
    global main
    extern printf, fgets, stdin

main:
    push rbp
    mov rbp, rsp

    mov rdi, input               ; &input[0]
    mov rsi, 255                 ; макс длина
    mov rdx, [stdin]             ; cin
    call fgets

    mov rbx, 0                   ; rbx = i (индекс в строке input, как в for)
    
    mov r12, 0                   ; currentNum, текущая позиция
    mov byte [currentNum + r12], 0

; Цикл for (int i = 0; i <= input.length()
read_char:
    mov al, [input + rbx]        ; с, текущий символ
    
    cmp al, 0
    je final_process
    cmp al, 10                   ; проверка на '\n' символ новой строки
    je final_process

    ; Проверка является ли символ цифрой:
    cmp al, '0'                  ; if (c < '0')
    jl check_non_digit
    cmp al, '9'                  ; if (c > '9')
    jg check_non_digit

; Если сивол - цифра:
    mov [currentNum + r12], al
    inc r12                      ; currentNum.length()++ добавляем след символ
    mov byte [currentNum + r12], 0
    
    ; Переход к следующему символу
    inc rbx                      ; i++
    jmp read_char

; Если символ не цифра:
check_non_digit:
    cmp r12, 0                   ; накопили ли число
    je check_invalid_char
    
    mov rsi, currentNum

    xor rax, rax                 ; int num = 0;

convert_loop:
    movzx rcx, byte [rsi]
    cmp rcx, 0                   ; if (digit == '\0')
    je done_convert              ;     break;
    
    ; Преобразование символа в число
    sub rcx, '0'                 ; rcx = числовое значение цифры 0-9
    
    ; num = num * 10
    mov rdx, 10
    mul rdx
    add rax, rcx
  
    inc rsi                      ; переход к следующему символу
    jmp convert_loop

done_convert:

    ; Проверка на однозначное
    cmp rax, 9                   ; if (num <= 9)
    jg count_even_digits

    ; Проверка что однозначное число от 1 до 9
    cmp rax, 1
    jl invalid_single_digit
   
    mov rdi, dash                ; вывод "- "
    call printf
    jmp clear_currentNum         ; очистка currentNum

invalid_single_digit:
    mov rdi, error_char          ; вывод сообщения об ошибке
    call printf
    mov rax, 1                   ; return 1
    jmp program_end

; Подсчет чётных цифр
count_even_digits:
    mov rcx, rax                 ; rcx = temp = num
    
    xor r8, r8                   ; r8 = evenCount = 0

count_loop:
    ; while (temp > 0)
    cmp rcx, 0                   ; if (temp == 0)
    je print_evenCount           ; вывод количества
    
    mov rax, rcx                 ; rax = temp
    xor rdx, rdx
    mov rsi, 10
    div rsi                      ; rdx = temp % 10 (digit), rax = temp / 10
    
    mov rcx, rax                 ; temp = temp / 10
    
    ; Проверяем на четность
    mov rax, rdx
    xor rdx, rdx
    mov rsi, 2
    div rsi                      ; rdx = digit % 2
    
    cmp rdx, 0                   ; if (digit % 2 != 0)
    jne count_loop
    inc r8                       ; evenCount++
    jmp count_loop
 
print_evenCount:
    mov rdi, fmt_int
    mov rsi, r8
    call printf                  ; вывод числа
    mov rdi, space               ; вывод пробела
    call printf
    jmp clear_currentNum         ; очистка
 
; Очистка currentNum
clear_currentNum:
    mov r12, 0
    mov byte [currentNum + r12], 0
    
    ;После очистки нужно проверить текущий символ (пробел или что-то другое)
    jmp check_current_char
 
; Обработка символа, который вызвал завершение числа (пробел, конец строки и т.д.)
check_current_char:
    mov al, [input + rbx]

    cmp al, ' '                  ; если пробел пропускаем
    je skip_process
    cmp al, 0                    ; если конец строки завершаем
    je final_process
    cmp al, 10
    je final_process
    
    mov rdi, error_char          ; вывод сообщения об ошибке недопустимого символа
    call printf
    mov rax, 1                   ; return 1
    jmp program_end

; Проверка на некорректные симвролы (когда нет накопленного числа)
check_invalid_char:
    cmp al, ' '                  ; если пробел
    je skip_process

    ; Если есть '-' то сразу ошибка недопустимого символа
    cmp al, '-'
    je invalid_char_error
    
    mov rdi, error_char          ; вывод сообщения об ошибке
    call printf
    mov rax, 1                   ; return 1
    jmp program_end

invalid_char_error:
    mov rdi, error_char          ; вывод Ошибка: недопустимый символ
    call printf
    mov rax, 1                   ; return 1
    jmp program_end
 
; Пропуск пробела
skip_process:
    inc rbx                      ; i++ переход к след символу
    jmp read_char

; После завершения цикла for, проверяем последнее число
final_process:
    cmp r12, 0                   ; если пусто
    je program_end               ; конец
    jmp check_non_digit          ; else обрабатываем последнее число
 
; Завершение
program_end:
    mov rdi, newline             ; cout << endl;
    call printf
    xor rax, rax                 ; return 0
    leave 
    ret
