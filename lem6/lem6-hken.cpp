#include <stdio.h>
#include <memory.h>
#include <algorithm>

using namespace std;

const int LM_BIGINT = 1000000000;
typedef int bigint[100];

int n, m;
int a[500];
bigint c1[1001], c2[1001];

void input() {
	scanf("%d%d", &n, &m);
	for (int i=0; i<m; i++) scanf("%d", &a[i]);
}

void output(int r[200]) {
	printf("%d", r[r[0]]);
	for(int i=r[0]-1;i>=1;--i) printf("%09d", r[i]);
	printf("\n");
}

void setx(bigint b, int x) {
	b[0] = 1;
	b[1] = x;
}

void setb(bigint b, bigint x) {
	for (int i=0; i<=x[0]; i++) b[i] = x[i];
}

void add(bigint x, bigint y) {
	int tmp;
	int carry = 0, t = max(x[0], y[0]);

	//
	for (int i=1; i<=t; i++) {
		//	
		tmp = carry;
		if (i <= x[0]) tmp += x[i];
		if (i <= y[0]) tmp += y[i];
	
		//
		if (tmp >= LM_BIGINT) { carry = 1; x[i] = tmp - LM_BIGINT; }
		else { carry = 0; x[i] = tmp; }
	}

	//
	x[0] = t;
	if (carry == 1) x[ ++x[0] ] = 1;
}

void dp(int k, bigint c1[1001], bigint c2[1001]) {
	//
	for (int i=0; i<=n; i++) setx(c2[i], 0);

	//
	for (int i=a[k]+1; i<=n; i++) {
		setb(c2[i], c1[i-a[k]-1]);
		add(c2[i], c2[i-1]);
	}
}

void process() {
	//
	for (int i=0; i<=n; i++) setx(c1[i], 0);
	for (int i=a[0]; i<=n; i++) setx(c1[i], i-a[0]+1);

	//
	for (int i=1; i<m; i++) {
		if (i%2 == 1) dp(i, c1, c2); else dp(i, c2, c1);
	}

	//
	output( ((m-1)%2==1) ? c2[n] : c1[n] );
}

int main() {
    //freopen("lem6.in", "r", stdin);
    freopen("lem6.out", "w", stdout);

	input();
	process();
    
    return 0;
}
