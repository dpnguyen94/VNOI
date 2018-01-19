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

int w[20], v[20];

void input() {
    printf("40 1000000000\n");
    REP(i,0,40) {
        w[i] = rand() % 100000000 + 50000000;
        //w[i] = 1;
        v[i] = rand() % 100000000 + 50000000;
        //v[i] = 100000000;
        
        printf("%d %d\n", w[i], v[i]);
    }
}

void process() {
    LL wt, vt, res = 0;
    REP(mask,0,1 << 20) {
        wt = vt = 0;
        REP(i,0,20) if ((mask >> i) & 1) {
            wt += w[i];
            vt += v[i];
        }
        
        if (wt <= 50000) 
            if (vt > res) res = vt;
    }
    
    printf("%I64d\n", res);
}

void output() {
}

int main() {
    freopen("dttui1.in1", "w", stdout);

    input();
    //process();
    output();

    return 0;
}
