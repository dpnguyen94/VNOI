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

const int MAXN = 10000;
const int MAXM = 100000;

void input() {
}

void process() {
    printf("%d\n", MAXN);
    printf("%d\n", MAXM);
    
    int num, u, v;
    REP(i,0,MAXM) {
        num = rand() % 3 + 1;
        if (num == 3) printf("%d\n", num);
        else {
            u = rand() % (MAXN / 2) + 1;
            v = u + (rand() % (MAXN / 2)) + 1;
            
            printf("%d %d %d\n", num, u, v);
        }
    }
}

void output() {
}

int main() {
    freopen("lem4.in1", "w", stdout);

    input();
    process();
    output();

    return 0;
}
