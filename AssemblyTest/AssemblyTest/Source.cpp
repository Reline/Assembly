#include <iostream>

extern "C" int getval();

int main() {

	std::cout << "Value: " << getval() << std::endl;

	system("pause");
	return 0;
}