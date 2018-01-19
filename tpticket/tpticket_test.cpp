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

const int MAXN = 100000;
const int MAXK = 100000;
const int MAXM = 500000;
const int MOD = MAXN / 2;

void input() {
}

void process() {
    printf("%d %d %d\n", MAXN, MAXK, MAXM);
    int X, Y;
    REP(i,0,MAXM) {
        X = rand() % MOD;
        Y = X + rand() % MOD;
        
        printf("%d %d\n", X, Y);
    }
}

void output() {
}

int main() {
    freopen("tpticket.in1", "w", stdout);

    input();
    process();
    output();

    return 0;
}
