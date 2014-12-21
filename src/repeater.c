#include <stdio.h>

int main() {
	int c;
	int p1=0,p2=0;
	while ( (c=getchar()) !=EOF ) {
		putchar(c);
		if (c == 'J' && p1 == '[' && p2 == 27) {
			putchar('\n');
			fflush(stdout);
		}
		p2 = p1; p1 = c;
	}
	return 0;
}