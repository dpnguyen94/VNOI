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
#define FORU(i,a,b) 	for (int i=(a),_b=(b);i<=_b;i++)
#define FORD(i,a,b) 	for (int i=(a),_b=(b);i>=_b;i--)
#define TR(c, it) 		for (typeof((c).begin()) it=(c).begin(); it!=(c).end(); it++)
#define pb 				push_back
#define mp 				make_pair
#define sz(c) 			int((c).size())
#define all(c) 			(c).begin(), (c).end()

typedef long long 		LL;
typedef unsigned long long 	ULL;
typedef vector<int> 	vi;
typedef vector<vi> 		vvi;
typedef vector<string> 	vs;
typedef pair<int, int> 	pii;
typedef pair<pii, int> 	piii;

set<pii> a;

void input() {
}

void process() {
    typeof (a.begin()) it;
    int x, k, p;
    while (true) {
        scanf("%d", &x);
        if (x == 0) break;
        
        if (x == 1) {
            scanf("%d %d", &k, &p);
            a.insert(mp(p,k));
        }
        if (x == 2) {
            if (a.empty()) printf("0\n");
            else {
                it = --a.end();
                printf("%d\n", it -> second);
                a.erase(it);
            }
        }
        if (x == 3) {
            if (a.empty()) printf("0\n");
            else {
                it = a.begin();
                printf("%d\n", it -> second);
                a.erase(it);
            }
        
        }
    }
}

void output() {
}

int main() {
    //freopen("mse07b.inp", "r", stdin);
    //freopen("mse07b.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
