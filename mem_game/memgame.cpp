#include <iostream>

using namespace std;

/**
 * Simple implementation of a memoru game.
 * Assumes the user will never choose an element
 * that was already selected.
 *
 * */

/**
 * Simple structure for a card on the board.
 *
 * */
struct Card {
	int symb;
	bool visible;	
};

/**
 * Simple gameState print, useless for circuit implementation
 *
 * */
void printBoard(Card (&table)[16]){

	for (int i = 0; i < 4; ++i)
	{
		for (int j = 0; j < 4; ++j)
		{
			if(table[i*4+j].visible == false)
				cout<< "X";
			else
				cout<<table[i*4+j].symb;
		}
		cout<<"\n";
	}
}

int main() {

	Card tab[16];

	// Setup
	for (int i = 0; i < 16; ++i) {
		Card c;
		c.symb = i % 8;
		c.visible = false;
		tab[i] = c;
	}
	
	// Control variable
	int p = 0;
	
	// Indicates user's score	
	int attempts = 0;
	
	// Choices	
	int choice1, choice2;

	//Initial State useless for circuit
	printBoard(tab);

	// Game loop 
	while (p < 8) {

		cin >> choice1;
		tab[choice1].visible = true;
		cin >> choice2;
		tab[choice2].visible = true;

		printBoard(tab); //Useless for circuit

		// Validation not necessary
		if (tab[choice1].symb == tab[choice2].symb) {

			cout << "Right!" << endl; // Useless for circuit
			++p;

		} else {

			tab[choice1].visible = false;
			tab[choice2].visible = false;
			cout << "Fail!" << endl; // Useless for circuit
		}

		printBoard(tab); //Useless for circuit

		attempts++;
	}

	cout << "Score: " << attempts << endl;

	return 0;
}
