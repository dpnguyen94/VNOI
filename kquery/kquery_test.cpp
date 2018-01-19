#include <stdio.h>
#include <math.h>
#include <limits.h>
#include <memory.h>
#include <algorithm>
#include <numeric>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <queue>
#include <stack>
#include <map>
#include <set>

using namespace std;

#define REP(i,a,b) 		for (int i=(a),_b=(b);i<_b;i++)
#define FOR(i,a,b) 		for (int i=(a),_b=(b);i<=_b;i++)
#define DOW(i,a,b) 		for (int i=(a),_b=(b);i>=_b;i--)
#define TR(c,it) 		for (typeof((c).begin()) it=(c).begin(); it!=(c).end(); it++)
#define pb 				push_back
#define mp 				make_pair
#define sz(c) 			int((c).size())
#define all(c) 			(c).begin(), (c).end()

typedef long long 		LL;
typedef unsigned long long 	ULL;
typedef pair<int, int> 	ii;
typedef pair<ii, int> 	iii;
typedef vector<int> 	vi;
typedef vector<vi> 		vvi;
typedef vector<string> 	vs;
typedef vector<ii> 	    vii;
typedef vector<vii> 	vvii;

const int MAXN = 30000;
const int MAXM = 100;
const int LM = 1000000000;

int a[MAXN], res[MAXM];

void input() {
    printf("%d\n", MAXN);
    REP(i,0,MAXN) {
        a[i] = rand() % LM + 1;
        printf("%d ", a[i]);
    }
    printf("\n%d\n", MAXM);
    int x, y, num, cnt;
    REP(i,0,MAXM) {
        x = rand() % 500 + 1;
        y = x + rand() % 500 + 1;
        num = rand() % LM + 1;
        
        printf("%d %d %d\n", x, y, num);
        
        x --; y --;
        cnt = 0;
        FOR(k,x,y) if (a[k] > num) cnt ++;
        res[i] = cnt;
    }
    
    REP(i,0,MAXM) printf("%d\n", res[i]);
}

void process() {
}

void output() {
}

int main() {
    freopen("kquery.in1", "w", stdout);

    input();
    process();
    output();

    return 0;
}
