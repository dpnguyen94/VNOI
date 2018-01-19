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

set<int> a, b;
set<int>::iterator it;

void input() {
}

void process() {
    int num, x;
    while (true) {
        scanf("%d", &x);
        if (x == 0) break;

        if (x == 1) {
            scanf("%d", &num);
            a.insert(num);
            b.insert(-num);
        }
        if (x == 2) {
            scanf("%d", &num);
            a.erase(num);
            b.erase(-num);
        }
        if (x == 3) {
            if (a.empty()) printf("empty\n");
            else printf("%d\n", *(a.begin()));
        }
        if (x == 4) {
            if (b.empty()) printf("empty\n");
            else printf("%d\n", -*(b.begin()));
        }
        if (x == 5) {
            scanf("%d", &num);
            if (a.empty()) printf("empty\n");
            it = a.upper_bound(num);
            if (it == a.end()) printf("no\n");
            else printf("%d\n", *it);
        }
        if (x == 6) {
            scanf("%d", &num);
            if (a.empty()) printf("empty\n");
            it = a.lower_bound(num);
            if (it == a.end()) printf("no\n");
            else printf("%d\n", *it);
        }
        if (x == 7) {
            scanf("%d", &num);
            if (b.empty()) printf("empty\n");
            it = b.upper_bound(-num);
            if (it == b.end()) printf("no\n");
            else printf("%d\n", -*it);
        }
        if (x == 8) {
            scanf("%d", &num);
            if (b.empty()) printf("empty\n");
            it = b.lower_bound(-num);
            if (it == b.end()) printf("no\n");
            else printf("%d\n", -*it);
        }
    }
}

void output() {
}

int main() {
    //freopen("cppset.inp", "r", stdin);
    //freopen("cppset.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
