#include <iostream>
#include <string>
using namespace std;

int main() {
    string input;
    getline(cin, input);
    
    string currentNum = "";  // Цифры текущего числа
    
    // Проходим по каждому символу введённой строки
    for (int i = 0; i <= input.length(); i++) {
        char c = input[i];
        
        // Проверяем является ли символ цифрой
        if (i < input.length() && c >= '0' && c <= '9') {
            currentNum += c;
        }
        else {
            // Если это не цифра, проверяем есть ли накопленное число и переводим эту строку в число
            if (!currentNum.empty()) {
                int num = 0;
                for (char digit : currentNum) {
                    num = num * 10 + (digit - '0');
                }
                
                // Проверка на натуральное число
                if (num <= 0) {
                    cout << "Ошибка: число " << num << " не натуральное!" << endl;
                    return 1;
                }
                
                // Если число однозначное
                if (num <= 9) {
                    cout << "- ";
                }
                else {
                    // Количество чётных цифр в числе
                    int evenCount = 0;
                    int temp = num;
                    
                    while (temp > 0) {
                        int digit = temp % 10;
                        
                        if (digit % 2 == 0) {
                            evenCount++;
                        }
                        
                        temp = temp / 10;
                    }
                    
                    cout << evenCount << " ";  // результат
                }
                
                currentNum = "";  // очищаем накопленное число для следующего
            }
            
            // Проверка на некорректные символы
            if (i < input.length() && c != ' ') {
                cout << "Ошибка: недопустимый символ '" << c << "'!" << endl;
                return 1;
            }
        }
    }
    
    return 0;
}
