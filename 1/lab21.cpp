#include <iostream>
#include <string>

using namespace std;

bool isCyclicShift(const string& S, const string& T) {

    // Если длины разные, циклический сдвиг невозможен
    if (S.length() != T.length()) {
        return false;
    }
    // Создаём строку из двух S подряд
    string doubled = S + S;

    // Проверяем встречается ли T внутри SS, если найдена => цикл сдвиг
	if (doubled.find(T) != string::npos) {
		return true;
	}
	return false;
}

int main() {

    string S, T;

    cout << "Введите строку S: ";
    cin >> S;

    cout << "Введите строку T: ";
    cin >> T;

    // Проверка на циклический сдвиг
    if (isCyclicShift(S, T)) {
        cout << "Yes" << endl;
    }
    else {
        cout << "No" << endl;
    }

    return 0;
}
